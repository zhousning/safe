class GrpSummariesController < ApplicationController
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
      items = fct.summaries.where(:end_date => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>查看</button>",
          :fct => fct.name,

          :start_date => item.start_date,

          :end_date => item.end_date,
         
          :title => item.title,
         
          :content => item.content,
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    summary = Summary.find(iddecode(params[:id]))
    @factory = summary.factory
    obj = []

    hash = Hash.new
    hash[Setting.summaries.attach] = download_append_grp_summary_path(idencode(summary.id))
    summary.attachments.each_with_index do |e, i|
      hash[File.basename(URI.decode(e.file_url))] = download_attachment_grp_summary_path(idencode(summary.id), :number => i, :ft => '')
    end

    obj << {
        :start_date => summary.start_date,

        :end_date => summary.end_date,
       
        :title => summary.title,
       
        :content => summary.content,
       
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
    @summary = Summary.find(iddecode(params[:id]))
    @attachment_id = params[:number].to_i
    @attachment = @summary.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
    @summary = Summary.find(iddecode(params[:id]))
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

