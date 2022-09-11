class RecheckResultsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @recheck_result = RecheckResult.new
   
    #@recheck_results = RecheckResult.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = RecheckResult.all
   
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
   
    @recheck_result = RecheckResult.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @recheck_result = RecheckResult.new
    
  end
   

   
  def create
    @recheck_result = RecheckResult.new(recheck_result_params)
     
    if @recheck_result.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @recheck_result = RecheckResult.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @recheck_result = RecheckResult.find(iddecode(params[:id]))
   
    if @recheck_result.update(recheck_result_params)
      redirect_to recheck_result_path(idencode(@recheck_result.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @recheck_result = RecheckResult.find(iddecode(params[:id]))
   
    @recheck_result.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
     
      @recheck_result = RecheckResult.find(iddecode(params[:id]))
     
      @attachment_id = params[:number].to_i
      @attachment = @recheck_result.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
    def download_append
     
      @recheck_result = RecheckResult.find(iddecode(params[:id]))
     
      @attach = @recheck_result.attach_url

      if @attach
        send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  
    def download_append
     
      @recheck_result = RecheckResult.find(iddecode(params[:id]))
     
      @idattach = @recheck_result.idattach_url

      if @idattach
        send_file File.join(Rails.root, "public", URI.decode(@idattach)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  
  

  private
    def recheck_result_params
      params.require(:recheck_result).permit( :worker, :signer, :search_date, :number, :content , :attach , :idattach , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

