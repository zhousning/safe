class TrainsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @factory = my_factory
    @trains = @factory.trains.order('train_time DESC').page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  #def query_all 
  #  items = Train.all
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
    @train = @factory.trains.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @factory = my_factory
    @train = Train.new
    
  end
   

   
  def create
    @factory = my_factory
    @train = Train.new(train_params)
     
    @train.factory = @factory 
     
    if @train.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @factory = my_factory
    @train = @factory.trains.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @factory = my_factory
    @train = @factory.trains.find(iddecode(params[:id]))
   
    if @train.update(train_params)
      redirect_to factory_train_path(idencode(@factory.id), idencode(@train.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @factory = my_factory
    @train = @factory.trains.find(iddecode(params[:id]))
   
    @train.destroy
    redirect_to :action => :index
  end
   

  
  def download_attachment 
     
    @factory = my_factory
    @train = @factory.trains.find(iddecode(params[:id]))
     
    @attachment_id = params[:number].to_i
    @attachment = @train.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
     
    @factory = my_factory
    @train = @factory.trains.find(iddecode(params[:id]))
     
    @wpaper = @train.wpaper_url

    if @wpaper
      send_file File.join(Rails.root, "public", URI.decode(@wpaper)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  
  

  private
    def train_params
      params.require(:train).permit(:people,  :title, :content, :place, :train_time, :address , :sign , :scene , :estimate , :paper , :wpaper , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

