class GrpWorkersController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

  def index
  end

  def query_all 
    items = Worker.where(:state => Setting.states.completed).order('created_at DESC').all
   
    obj = []
    items.each do |item|
      obj << {
        :id => idencode(item.id),
        :idno => item.idno,
        :name => item.name,
        :phone => item.phone,
        :gender => user_gender(item.gender),
        :adress => item.adress,
        :fct => Factory.find(item.factory).name
      }
    end
    obj
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end
   
  def query_info 
    @worker = Worker.find(iddecode(params[:id]))
   
    info = [@worker.name, @worker.idno, @worker.phone]
    imgs = []
    @worker.img.split(',').each do |item|
      imgs << item 
    end
    respond_to do |f|
      f.json{ render :json => {:info => info, :img => imgs}.to_json}
    end
  end
   
   
  def signlogs
    @worker = Worker.find(iddecode(params[:id]))
    @sign_logs = @worker.sign_logs.order('created_at DESC') 
    obj = []
    @sign_logs.each do |item|
      obj << {
        :time => item.created_at.strftime('%Y-%m-%d %H:%M:%S'),
        :fzr => WxUser.find(item.wx_user_id).name,
        :zd => Device.find(item.device_id).name,
        :img => item.avatar_url
      }
    end
    obj
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end
  
end

