class ModifyResultsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @modify_result = ModifyResult.new
   
    #@modify_results = ModifyResult.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = ModifyResult.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :worker => item.worker,
       
        :signer => item.signer,
       
        :search_date => item.search_date,
       
        :number => item.number,
       
        :content => item.content
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @modify_result = ModifyResult.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @modify_result = ModifyResult.new
    
  end
   

   
  def create
    @modify_result = ModifyResult.new(modify_result_params)
     
    if @modify_result.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @modify_result = ModifyResult.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @modify_result = ModifyResult.find(iddecode(params[:id]))
   
    if @modify_result.update(modify_result_params)
      redirect_to modify_result_path(idencode(@modify_result.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @modify_result = ModifyResult.find(iddecode(params[:id]))
   
    @modify_result.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
     
      @modify_result = ModifyResult.find(iddecode(params[:id]))
     
      @attachment_id = params[:number].to_i
      @attachment = @modify_result.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
    def download_append
     
      @modify_result = ModifyResult.find(iddecode(params[:id]))
     
      @attach = @modify_result.attach_url

      if @attach
        send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  
    def download_append
     
      @modify_result = ModifyResult.find(iddecode(params[:id]))
     
      @idattach = @modify_result.idattach_url

      if @idattach
        send_file File.join(Rails.root, "public", URI.decode(@idattach)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  
  

  private
    def modify_result_params
      params.require(:modify_result).permit( :worker, :signer, :search_date, :number, :content , :attach , :idattach , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

