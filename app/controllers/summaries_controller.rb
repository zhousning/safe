class SummariesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
   
    @factory = my_factory
    @summaries = @factory.summaries.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  #def query_all 
  #  items = Summary.all
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
  #      :place => item.place
  #    
  #    }
  #  end
  #  respond_to do |f|
  #    f.json{ render :json => obj.to_json}
  #  end
  #end



   
  def show
   
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @factory = my_factory
    @summary = Summary.new
    
  end
   

   
  def create
    @factory = my_factory
    @summary = Summary.new(summary_params)
     
    @summary.factory = @factory 
     
    if @summary.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
   
    if @summary.update(summary_params)
      redirect_to factory_summary_path(idencode(@factory.id), idencode(@summary.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
   
    @summary.destroy
    redirect_to :action => :index
  end
   

  
  def download_attachment 
     
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
     
    @attachment_id = params[:number].to_i
    @attachment = @summary.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
     
    @factory = my_factory
    @summary = @factory.summaries.find(iddecode(params[:id]))
     
    @attach = @summary.attach_url

    if @attach
      send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  
  

  private
    def summary_params
      params.require(:summary).permit( :title, :content, :place , :attach , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

