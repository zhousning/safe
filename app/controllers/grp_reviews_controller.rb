class GrpReviewsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @grp_reviews = GrpReview.order('search_date DESC').page( params[:page]).per( Setting.systems.per_page )
  end
   
  def show
    @grp_review = GrpReview.find(iddecode(params[:id]))
    @reviews = @grp_review.reviews
  end

  def new
    @grp_review = GrpReview.new
    
    #@review.exm_items.build
  end
   
  def create
    @grp_review = GrpReview.new(grp_review_params)
    if @grp_review.save
      redirect_to grp_reviews_path
    else
      render :new
    end
  end
   
  def edit
    @grp_review = GrpReview.find(iddecode(params[:id]))
  end
   
  def update
    @grp_review = GrpReview.find(iddecode(params[:id]))
    if @grp_review.update(grp_review_params)
      redirect_to grp_reviews_path
    else
      render :edit
    end
  end
   
  def destroy
    @grp_review = GrpReview.find(iddecode(params[:id]))
    @grp_review.destroy
    redirect_to :action => :index
  end


  def review
    @grp_review = GrpReview.find(iddecode(params[:id]))
    @review = Review.find(iddecode(params[:review_id]))
  end

  
    def download_attachment 
     
      @grp_review = GrpReview.find(iddecode(params[:id]))
     
      @attachment_id = params[:number].to_i
      @attachment = @grp_review.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
    def download_append
     
      @grp_review = GrpReview.find(iddecode(params[:id]))
     
      @attch = @grp_review.attch_url

      if @attch
        send_file File.join(Rails.root, "public", URI.decode(@attch)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  def publish 
    @grp_review = GrpReview.find(params[:id])
    puts @grp_review.state
    if @grp_review.state != Setting.states.published
      begin
        Review.transaction do
          Factory.all.each do |factory|
            Review.create!(:factory => factory, :grp_review => @grp_review, :name => @grp_review.name, :search_date => @grp_review.search_date, :content => @grp_review.content)
          end
        end
        @grp_review.published
      rescue Exception => e
        puts e.message
      end
    end
    redirect_to grp_reviews_path
  end
  
  

  private
    def grp_review_params
      params.require(:grp_review).permit( :name, :search_date, :content, :state, :desc1, :desc2 , :attch , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

