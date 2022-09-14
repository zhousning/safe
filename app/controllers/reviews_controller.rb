class ReviewsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

  def index
    @factory = my_factory
    @reviews = @factory.reviews.order('search_date DESC').page( params[:page]).per( Setting.systems.per_page )
  end
   
  def show
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:id]))
    @grp_review = @review.grp_review
    @modify_result = @review.modify_result
    @recheck_result = @review.recheck_result
    @review_result = @review.review_result
  end

  def report 
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:id]))
    @review.report
    redirect_to factory_review_path(idencode(@factory.id), idencode(@review.id)) 
  end

  def reject
    @factory = Factory.find(iddecode(params[:factory_id])) 
    @review = @factory.reviews.find(iddecode(params[:id]))
    @grp_review = @review.grp_review
    @review.reject
    redirect_to review_grp_review_path(idencode(@grp_review.id), :review_id => idencode(@review.id)) 
  end
  
  def complete 
    @factory = Factory.find(iddecode(params[:factory_id])) 
    @review = @factory.reviews.find(iddecode(params[:id]))
    @grp_review = @review.grp_review
    @review.completed
    redirect_to review_grp_review_path(idencode(@grp_review.id), :review_id => idencode(@review.id)) 
  end
  
  
  def download_attachment 
   
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:id]))
   
    @attachment_id = params[:number].to_i
    @attachment = @review.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_append
   
    @factory = my_factory
    @review = @factory.reviews.find(iddecode(params[:id]))
   
    @attch = @review.attch_url

    if @attch
      send_file File.join(Rails.root, "public", URI.decode(@attch)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  private
    def review_params
      params.require(:review).permit( :name, :search_date, :content, :state, :desc1, :desc2 , :attch , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

