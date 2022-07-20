class WorkersController < ApplicationController
  include BaiduFace
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

  def index
    @factory = my_factory
    gon.fct = idencode(@factory.id)
    @workers = Worker.where(:factory => @factory.id).order('created_at DESC').page( params[:page]).per( Setting.systems.per_page )
  end
   
  def receive 
    @factory = my_factory
    @worker = Worker.where(:factory => @factory.id, :id => iddecode(params[:id])).first
    if @worker.state != Setting.states.completed
      @worker.processing
      BaiduFaceWorker.perform_async(@worker.id)
    end
    redirect_to :action => :index
  end

  def reject 
    @factory = my_factory
    @worker = Worker.where(:factory => @factory.id, :id => iddecode(params[:id])).first
    @worker.ongoing if @worker.state != Setting.states.completed
    redirect_to :action => :index
  end

  def query_info 
    @factory = my_factory
    @worker = Worker.where(:factory => @factory.id, :id => iddecode(params[:id])).first
   
    info = [@worker.name, @worker.idno, @worker.phone]
    imgs = []
    @worker.img.split(',').each do |item|
      imgs << item 
    end
    respond_to do |f|
      f.json{ render :json => {:info => info, :img => imgs}.to_json}
    end
  end
   
  def destroy
    @factory = my_factory
    @worker = Worker.where(:factory => @factory.id, :id => iddecode(params[:id])).first
    if @worker.state != Setting.states.completed
      body = delete_user(@worker.idno)
      if body['error_code'] == 0
        @worker.destroy
      end
    end
    redirect_to :action => :index
  end
   
  def signlogs
    @factory = my_factory
    @worker = Worker.where(:factory => @factory.id, :id => iddecode(params[:id])).first
    @sign_logs = @worker.sign_logs.order('created_at DESC') 
  end
  
  private
    def worker_params
      params.require(:worker).permit( :name, :idno, :phone, :gender, :state, :adress, :desc , :avatar , :idfront , :idback)
    end
  
  
  
end

#def new
#  @worker = Worker.new
#  
#end
# 

#def show
# 
#  @worker = Worker.find(iddecode(params[:id]))
# 
#end
 
# 
#def create
#  @worker = Worker.new(worker_params)
#  face_worker = BaiDuFace.new
#   
#  if @worker.save
#    unless @worker.avatar.file.nil?
#      image = File.join(Rails.root, 'public', @worker.avatar_url)
#      image_base64 = Base64.encode64(File.read(image)).gsub(/\s/, '')
#      @worker.update_attributes!(:avatar_base => image_base64)

#      face_worker.add_face_entity(@worker.id)
#    end

#    redirect_to :action => :index
#  else
#    render :new
#  end
#end
# 

# 
#def edit
# 
#  @worker = Worker.find(iddecode(params[:id]))
# 
#end
# 

# 
#def update
# 
#  @worker = Worker.find(iddecode(params[:id]))
# 
#  if @worker.update(worker_params)
#    unless @worker.avatar.file.nil?
#      image = File.join(Rails.root, 'public', @worker.avatar_url)
#      image_base64 = Base64.encode64(File.read(image)).gsub(/\s/, '')
#      @worker.update_attributes!(:avatar_base => image_base64)
#    end
#    redirect_to edit_worker_path(idencode(@worker.id)) 
#  else
#    render :edit
#  end
#end
 

 




