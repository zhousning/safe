require 'json'

class GrpExaminesController < ApplicationController
  protect_from_forgery :except => :create_drct

  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource :except => :create_drct
   
  def index
    @grp_examines = GrpExamine.order('search_date DESC').all.page( params[:page]).per( Setting.systems.per_page )
  end
   
  def show
    @grp_examine = GrpExamine.find(params[:id])
    @examines = Examine.where(:grp_examine_id => params[:id])
  end

  def new
    @grp_examine = GrpExamine.new
  end
   
  def create
    @grp_examine = GrpExamine.new(examine_params)
    if @grp_examine.save
      redirect_to grp_examines_path
    else
      render :new
    end
  end
   
  def edit
    @grp_examine = GrpExamine.find(params[:id])
  end
   
  def update
    @grp_examine = GrpExamine.find(params[:id])
    if @grp_examine.update(examine_params)
      redirect_to grp_examines_path
    else
      render :edit
    end
  end
   
  def destroy
    @grp_examine = GrpExamine.find(params[:id])
    @grp_examine.destroy
    redirect_to :action => :index
  end

  def drct_org
    @grp_examine = GrpExamine.find(params[:id])
    hercy = @grp_examine.hierarchy
    gon.rightnodes = hercy.blank? ? '{"name": "' + @grp_examine.name + '", "isParent": true, "nodeid": null}' : hercy
    gon.examine = params[:id]
  end

  def drct_info
    @examine = Examine.find(iddecode(params[:id]))
    hercy = @examine.hierarchy
    nodes = hercy.blank? ? '{"name": "' + @examine.name + '", "isParent": true, "nodeid": null}' : hercy
    respond_to do |f|
      f.json { render :json => {:nodes => nodes}.to_json }
    end
  end

  def create_drct
    @examine = GrpExamine.find(params[:id])
    drct_data = params[:drct_data]
    if @examine.update_attributes(:hierarchy => drct_data)
      respond_to do |f|
        f.json { render :json => {:status => "保存成功"}.to_json }
      end
    else
      respond_to do |f|
        f.json { render :json => {:status => "保存失败"}.to_json }
      end
    end
  end
   
  def export
    @examine = GrpExamine.find(params[:id])
    number = Time.now.to_i.to_s + "%04d" % [rand(10000)]
    @document = Document.new(:examine => @examine, :title => number, :status => Setting.documents.status_none)
    if @document.save
      ExportWorker.perform_async(@examine.id, @document.id, number)
      redirect_to examine_documents_path(@examine)
    else
      redirect_to :back
    end
  end

  def publish 
    @grp_examine = GrpExamine.find(params[:id])
    if @grp_examine.state != Setting.states.published
      begin
        Examine.transaction do
          Factory.all.each do |factory|
            Examine.create!(:factory => factory, :grp_examine => @grp_examine, :name => @grp_examine.name, :hierarchy => @grp_examine.hierarchy)
          end
        end
        @grp_examine.published
      rescue
      end
    else
      begin
        Examine.transaction do
          @grp_examine.examines.each do |examine|
            examine.update_attributes!(:name => @grp_examine.name, :hierarchy => @grp_examine.hierarchy)
          end
        end
      rescue
      end
    end
    redirect_to grp_examines_path
  end

  def reject_examine
    @grp_examine = GrpExamine.find(iddecode(params[:id]))
    @examine = @grp_examine.examines.find(iddecode(params[:examine_id]))
    @examine.reject
    redirect_to grp_examine_path(@grp_examine)
  end

  def download_examine 
    @examine = Examine.find(iddecode(params[:examine_id]))

    if @examine
      send_file File.join(Rails.root, "public", "examines", @examine.id.to_s, @examine.html_link), :filename => @examine.grp_examine.name, :type => "application/force-download", :x_sendfile=>true 
    end
  end


  private
    def examine_params
      params.require(:grp_examine).permit( :name, :search_date, :content, exm_items_attributes: exm_item_params)
    end
  
  
  
    def exm_item_params
      [:id, :name ,:_destroy]
    end
  
end

