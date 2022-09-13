class ReviewResultsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

  def edit
   
    @factory = grp_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @grp_review = @review.grp_review
    @review_result = @review.review_result
   
  end
   

   
  def update
   
    @factory =Factory.find(params[:factory_id])
    @review = @factory.reviews.find(params[:review_id])
    @review_result = @review.review_result
   
    if @review_result.update(review_result_params)
      redirect_to edit_factory_review_review_result_path(idencode(@factory.id), idencode(@review.id), idencode(@review_result.id))
    else
      render :edit
    end
  end
   
  def publish 
    @factory = grp_factory
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @review_result = @review.review_result
    @grp_review = @review.grp_review
   
    if @review.modifying
      redirect_to grp_review_path(idencode(@grp_review.id))
    else
      render :edit
    end
  end
   

  
  def download_attachment 
   
    @factory =Factory.find(iddecode(params[:factory_id]))
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @review_result = @review.review_result
   
    @attachment_id = params[:number].to_i
    @attachment = @review_result.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
   
    @factory =Factory.find(iddecode(params[:factory_id]))
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @review_result = @review.review_result
   
    @attach = @review_result.attach_url

    if @attach
      send_file File.join(Rails.root, "public", URI.decode(@attach)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_idappend
    @factory =Factory.find(iddecode(params[:factory_id]))
    @review = @factory.reviews.find(iddecode(params[:review_id]))
    @review_result = @review.review_result
   
    @idattach = @review_result.idattach_url

    if @idattach
      send_file File.join(Rails.root, "public", URI.decode(@idattach)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

   
  #def index
  #  @review_result = ReviewResult.new
  # 
  #  #@review_results = ReviewResult.all.page( params[:page]).per( Setting.systems.per_page )
  # 
  #end
  # 

  #def query_all 
  #  items = ReviewResult.all
  # 
  #  obj = []
  #  items.each do |item|
  #    obj << {
  #      #:factory => idencode(factory.id),
  #      :id => idencode(item.id),
  #     
  #      :worker => item.worker,
  #     
  #      :signer => item.signer,
  #     
  #      :search_date => item.search_date,
  #     
  #      :number => item.number,
  #     
  #      :content => item.content
  #    
  #    }
  #  end
  #  respond_to do |f|
  #    f.json{ render :json => obj.to_json}
  #  end
  #end



  # 
  #def show
  # 
  #  @review_result = ReviewResult.find(iddecode(params[:id]))
  # 
  #end
  # 

  # 
  #def new
  #  @review_result = ReviewResult.new
  #  
  #end
  # 

  # 
  #def create
  #  @review_result = ReviewResult.new(review_result_params)
  #   
  #  if @review_result.save
  #    redirect_to :action => :index
  #  else
  #    render :new
  #  end
  #end
   
   
  #def destroy
  # 
  #  @review_result = ReviewResult.find(iddecode(params[:id]))
  # 
  #  @review_result.destroy
  #  redirect_to :action => :index
  #end
   

   
  
  
  

  private
    def review_result_params
      params.require(:review_result).permit( :worker, :signer, :search_date, :number, :content , :attach , :idattach , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

