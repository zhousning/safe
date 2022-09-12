class RecheckResultsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

  def edit
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @recheck_result = @review.recheck_result
  end
   

   
  def update
    @factory = Factory.find(params[:factory_id]) 
    @review = @factory.reviews.find(params[:review_id])
    @recheck_result = @review.recheck_result
   
    if @recheck_result.update(recheck_result_params)
      redirect_to edit_factory_review_recheck_result_path(idencode(@factory.id), idencode(@review.id), idencode(@recheck_result.id))
    end
  end

  def recheck
    @factory = Factory.find(iddecode(params[:factory_id])) 
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @recheck_result = @review.recheck_result

    if @review.review
      redirect_to factory_reviews_path(idencode(@factory.id), idencode(@review.id))
    else
      redirect_to edit_factory_review_recheck_result_path(idencode(@factory.id), idencode(@review.id), idencode(@recheck_result.id))
    end
  end
   
   
  
  def download_attachment 
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @recheck_result = @review.recheck_result
     
    @attachment_id = params[:number].to_i
    @attachment = @recheck_result.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @recheck_result = @review.recheck_result
   
    @attach = @recheck_result.attach_url

    if @attach
      send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_append
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @recheck_result = @review.recheck_result
   
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

