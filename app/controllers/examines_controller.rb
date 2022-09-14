require 'json'

class ExaminesController < ApplicationController
  protect_from_forgery :except => :create_drct

  layout "application_control"
  before_filter :authenticate_user!, :except => :create_drct
  authorize_resource :except => :create_drct
   
  def index
    @factory = my_factory
    @examines = @factory.examines.order('created_at DESC').page( params[:page]).per( Setting.systems.per_page )
  end
   
  def drct_org
    @factory = my_factory
    gon.fct = idencode(@factory.id)
    gon.leftnodes = []
    archives = @factory.archives
    archives.each do |archive|
      arc_h = Hash.new
      arc_h['name'] = archive.name
      arc_h['drag'] = false 
      arc_h['open'] = true 
      arc_arr = []

      portfolios = archive.portfolios
      portfolios.each do |portfolio|
        ptf_h = Hash.new
        ptf_h['name'] = portfolio.name
        ptf_h['drag'] = false
        ptf_h['open'] = true 
        ptf_arr = []

        file_libs = portfolio.file_libs
        file_libs.each do |file|
          ptf_arr << {'name': file.name, 'nodeid': file.id}
        end
        ptf_h['children'] = ptf_arr
        arc_arr << ptf_h
      end
      arc_h['children'] = arc_arr
      gon.leftnodes << arc_h
    end

    @examine = @factory.examines.find(params[:id])
    hercy = @examine.hierarchy
    gon.rightnodes = hercy.blank? ? '{"name": "' + @examine.name + '", "isParent": true, "nodeid": null}' : hercy
    gon.examine = params[:id]
  end

  def create_drct
    @factory = my_factory
    @examine = @factory.examines.find(params[:id])
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
    @factory = my_factory
    @examine = @factory.examines.find(params[:id])

    if @examine
      send_file File.join(Rails.root, "public", "examines", @examine.id.to_s, @examine.html_link), :filename => @examine.grp_examine.name, :type => "application/force-download", :x_sendfile=>true 
    end
  end

  def report 
    @factory = my_factory
    @examine = @factory.examines.find(params[:id])
    @examine.process
    ExportWorker.perform_async(@examine.id)
    redirect_to :action => :index
  end

  private
    def examine_params
      params.require(:examine).permit( :name, exm_items_attributes: exm_item_params)
    end
  
  
  
    def exm_item_params
      [:id, :name ,:_destroy]
    end
  
end

