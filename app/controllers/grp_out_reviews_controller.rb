class GrpOutReviewsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

   
   
  def query_list
    _start = params[:start].gsub(/\s/, '')
    _end = params[:end].gsub(/\s/, '')
    fcts = params[:fcts].gsub(/\s/, '').split(",")

    fcts = fcts.collect do |fct|
      iddecode(fct)
    end
    @factories = Factory.find(fcts)

    obj = []
    @factories.each do |fct|
      items = fct.out_reviews.where(:search_date => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>查看</button>",

         
          :title => item.title,

          :desc1 => item.desc1,
         
          :search_date => item.search_date,
         
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    out_review = OutReview.find(iddecode(params[:id]))
    @factory = out_review.factory
    obj = []
    hash = Hash.new
    hash[Setting.out_reviews.official] = download_official_grp_out_review_path(idencode(out_review.id))
    hash[Setting.out_reviews.result] = download_result_grp_out_review_path(idencode(out_review.id))
    hash[Setting.out_reviews.modified] = download_modified_grp_out_review_path(idencode(out_review.id))
    hash[Setting.out_reviews.recheck] = download_recheck_grp_out_review_path(idencode(out_review.id))

    out_review.attachments.each_with_index do |e, i|
      hash[File.basename(URI.decode(e.file_url))] = download_attachment_grp_out_review_path(idencode(out_review.id), :number => i, :ft => '')
    end

    obj << {
        :title => out_review.title,
       
        :desc1 => out_review.desc1,

        :search_date => out_review.search_date,
       
        :content => out_review.content,

        :attchs => hash
       
    }
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end


   
  def index
     
    @factories = Factory.all
     
  end
   

  def download_attachment 
    @out_review = OutReview.find(iddecode(params[:id]))
    @attachment_id = params[:number].to_i
    @attachment = @out_review.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_official
    @out_review = OutReview.find(iddecode(params[:id]))
    @official = @out_review.official_url

    if @official
      send_file File.join(Rails.root, "public", URI.decode(@official)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_result
    @out_review = OutReview.find(iddecode(params[:id]))
    @result = @out_review.result_url

    if @result
      send_file File.join(Rails.root, "public", URI.decode(@result)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_modified
    @out_review = OutReview.find(iddecode(params[:id]))
    @modified = @out_review.modified_url

    if @modified
      send_file File.join(Rails.root, "public", URI.decode(@modified)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  def download_recheck
    @out_review = OutReview.find(iddecode(params[:id]))
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

