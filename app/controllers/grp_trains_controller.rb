class GrpTrainsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
   
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
      items = fct.trains.where(:search_date => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>modal弹窗</button>",

         
          :title => item.title,
         
          :content => item.content,
         
          :place => item.place,
         
          :train_time => item.train_time,
         
          :address => item.address
        
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    train = Train.find(iddecode(params[:id]))
    obj = []
    obj << {
      :time => train.created_at.strftime('%Y-%m-%d %H:%M:%S'),
       
        :title => train.title,
       
        :content => train.content,
       
        :place => train.place,
       
        :train_time => train.train_time,
       
        :address => train.address
      
    }
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end


   
  def index
     
    @factories = Factory.all
     
    @trains = Train.all.page( params[:page]).per( Setting.systems.per_page )
  end
   

  def query_all 
    items = Train.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title,
       
        :content => item.content,
       
        :place => item.place,
       
        :train_time => item.train_time,
       
        :address => item.address
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
    @train = Train.find(iddecode(params[:id]))
  end
   

   
  def new
    @train = Train.new
    
  end
   

   
  def create
    @train = Train.new(train_params)
    if @train.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
    @train = Train.find(iddecode(params[:id]))
  end
   

   
  def update
    @train = Train.find(iddecode(params[:id]))
    if @train.update(train_params)
      redirect_to train_path(idencode(@train.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @train = Train.find(iddecode(params[:id]))
    @train.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @train = Train.find(iddecode(params[:id]))
      @attachment_id = params[:number].to_i
      @attachment = @train.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
    def download_append
      @train = Train.find(iddecode(params[:id]))
      @wpaper = @train.wpaper_url

      if @wpaper
        send_file File.join(Rails.root, "public", URI.decode(@wpaper)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  
  

  private
    def train_params
      params.require(:train).permit( :title, :content, :place, :train_time, :address , :sign , :scene , :estimate , :paper , :wpaper , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end
