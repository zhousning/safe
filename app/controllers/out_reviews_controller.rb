class OutReviewsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

   
  def index
    @factory = my_factory
   
    @out_reviews = @factory.out_reviews.order('search_date DESC').page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def show
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @factory = my_factory
    @out_review = OutReview.new
    
  end
   

   
  def create
    @factory = my_factory
    @out_review = OutReview.new(out_review_params)
    @out_review.factory = @factory
     
    if @out_review.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    if @out_review.update(out_review_params)
      redirect_to factory_out_review_path(idencode(@factory.id), idencode(@out_review.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @out_review.destroy
    redirect_to :action => :index
  end
   

  
  def download_attachment 
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @attachment_id = params[:number].to_i
    @attachment = @out_review.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_official
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @official = @out_review.official_url

    if @official
      send_file File.join(Rails.root, "public", URI.decode(@official)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_result
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @result = @out_review.result_url

    if @result
      send_file File.join(Rails.root, "public", URI.decode(@result)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_modified
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @modified = @out_review.modified_url

    if @modified
      send_file File.join(Rails.root, "public", URI.decode(@modified)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_recheck
   
    @factory = my_factory
    @out_review = @factory.out_reviews.find(iddecode(params[:id]))
   
    @recheck = @out_review.recheck_url

    if @recheck
      send_file File.join(Rails.root, "public", URI.decode(@recheck)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  
  

  private
    def out_review_params
      params.require(:out_review).permit( :title, :search_date, :content, :state, :desc1, :desc2 , :official , :result , :modified , :recheck , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

