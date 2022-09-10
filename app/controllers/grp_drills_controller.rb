class GrpDrillsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
   
  def query_list
    _start = params[:start].gsub(/\s/, '')
    _end = params[:end].gsub(/\s/, '')
    fcts = params[:fcts].gsub(/\s/, '').split(",")

    fcts = fcts.collect do |fct|
      iddecode(fct)
    end
    @factories = Factory.find(fcts)

    obj = []
    @factories.each do |fct|
      items = fct.drills.where(:train_time => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>modal弹窗</button>",

         
          :title => item.title,
         
          :content => item.content,
         
          :place => item.place,
         
          :train_time => item.train_time,
         
          :address => item.address
        
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    drill = Drill.find(iddecode(params[:id]))
    obj = []
    obj << {
      :time => drill.created_at.strftime('%Y-%m-%d %H:%M:%S'),
       
        :title => drill.title,
       
        :content => drill.content,
       
        :place => drill.place,
       
        :train_time => drill.train_time,
       
        :address => drill.address
      
    }
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end


   
  def index
     
    @factories = Factory.all
     
    @drills = Drill.all.page( params[:page]).per( Setting.systems.per_page )
  end
   

  def query_all 
    items = Drill.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title,
       
        :content => item.content,
       
        :place => item.place,
       
        :train_time => item.train_time,
       
        :address => item.address
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
    @drill = Drill.find(iddecode(params[:id]))
  end
   

   
  def new
    @drill = Drill.new
    
  end
   

   
  def create
    @drill = Drill.new(drill_params)
    if @drill.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
    @drill = Drill.find(iddecode(params[:id]))
  end
   

   
  def update
    @drill = Drill.find(iddecode(params[:id]))
    if @drill.update(drill_params)
      redirect_to drill_path(idencode(@drill.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @drill = Drill.find(iddecode(params[:id]))
    @drill.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @drill = Drill.find(iddecode(params[:id]))
      @attachment_id = params[:number].to_i
      @attachment = @drill.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
    def download_append
      @drill = Drill.find(iddecode(params[:id]))
      @summary = @drill.summary_url

      if @summary
        send_file File.join(Rails.root, "public", URI.decode(@summary)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  
  

  private
    def drill_params
      params.require(:drill).permit( :title, :content, :place, :train_time, :address , :sign , :scene , :estimate , :summary , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

