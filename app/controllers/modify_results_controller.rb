class ModifyResultsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

  def edit
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @modify_result = @review.modify_result
  end
   

   
  def update
    @factory = Factory.find(params[:factory_id]) 
    @review = @factory.reviews.find(params[:review_id])
    @modify_result = @review.modify_result
   
    if @modify_result.update(modify_result_params)
      redirect_to edit_factory_review_modify_result_path(idencode(@factory.id), idencode(@review.id), idencode(@modify_result.id))
    else
      render :edit
    end
  end


  def modify 
    @factory = Factory.find(iddecode(params[:factory_id])) 
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @modify_result = @review.modify_result
    if @review.modified
      redirect_to factory_reviews_path(idencode(@factory.id), idencode(@review.id))
    else
      redirect_to edit_factory_review_modify_result_path(idencode(@factory.id), idencode(@review.id), idencode(@modify_result.id))
    end
  end
   
  
  def download_attachment 
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @modify_result = @review.modify_result
     
    @attachment_id = params[:number].to_i
    @attachment = @modify_result.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @modify_result = @review.modify_result
   
    @attach = @modify_result.attach_url

    if @attach
      send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_append
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @modify_result = @review.modify_result
   
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

