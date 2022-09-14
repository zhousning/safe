class GrpDrillsController < ApplicationController
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
      items = fct.drills.where(:train_time => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>查看</button>",

          :fct => fct.name,
         
          :title => item.title,
         
          :people => item.people,
         
          :train_time => item.train_time.strftime('%Y-%m-%d %H:%M:%S'),
         
          :address => item.address
        
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    drill = Drill.find(iddecode(params[:id]))
    @factory = drill.factory
    obj = []
    img_hash = Hash.new
    img_hash[Setting.drills.sign] = drill.sign_url
    img_hash[Setting.drills.scene] = drill.scene_url     
    img_hash[Setting.drills.estimate] = drill.estimate_url 

    hash = Hash.new
    hash[Setting.drills.summary] = download_append_grp_drill_path(idencode(drill.id))
    drill.attachments.each_with_index do |e, i|
      hash[File.basename(URI.decode(e.file_url))] = download_attachment_grp_drill_path(idencode(drill.id), :number => i, :ft => '')
    end


    obj << {
        :title => drill.title,
       
        :content => drill.content,
       
        :number => drill.people,
       
        :train_time => drill.train_time.strftime('%Y-%m-%d %H:%M:%S'),
       
        :address => drill.address,
      
        :imgs => img_hash, 

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
    @drill = Drill.find(iddecode(params[:id]))
    @attachment_id = params[:number].to_i
    @attachment = @drill.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  
  def download_append
    @drill = Drill.find(iddecode(params[:id]))
    @summary = @drill.summary_url

    if @summary
      send_file File.join(Rails.root, "public", URI.decode(@summary)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  

  private
    def drill_params
      params.require(:drill).permit( :title, :content, :place, :train_time, :address , :sign , :scene , :estimate , :summary , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

