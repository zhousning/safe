class DrillsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
   
    @factory = my_factory
    @drills = @factory.drills.order('train_time DESC').page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  #def query_all 
  #  items = Drill.all
  # 
  #  obj = []
  #  items.each do |item|
  #    obj << {
  #      #:factory => idencode(factory.id),
  #      :id => idencode(item.id),
  #     
  #      :title => item.title,
  #     
  #      :content => item.content,
  #     
  #      :place => item.place,
  #     
  #      :train_time => item.train_time,
  #     
  #      :address => item.address
  #    
  #    }
  #  end
  #  respond_to do |f|
  #    f.json{ render :json => obj.to_json}
  #  end
  #end



   
  def show
   
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @factory = my_factory
    @drill = Drill.new
    
  end
   

   
  def create
    @factory = my_factory
    @drill = Drill.new(drill_params)
     
    @drill.factory = @factory 
     
    if @drill.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
   
    if @drill.update(drill_params)
      redirect_to factory_drill_path(idencode(@factory.id), idencode(@drill.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
   
    @drill.destroy
    redirect_to :action => :index
  end
   

  
  def download_attachment 
     
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
     
    @attachment_id = params[:number].to_i
    @attachment = @drill.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
   
    @factory = my_factory
    @drill = @factory.drills.find(iddecode(params[:id]))
     
    @summary = @drill.summary_url

    if @summary
      send_file File.join(Rails.root, "public", URI.decode(@summary)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  
  

  private
    def drill_params
      params.require(:drill).permit(:people, :title, :content, :place, :train_time, :address , :sign , :scene , :estimate , :summary , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

