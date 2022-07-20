class GrpSignLogsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  authorize_resource

   
  def index
  end
   
  def query_device
    @devices = Device.all
    result = []
    @devices.each do |device|
      result << {
        id: idencode(device.id),
        text: device.mdno + ' - ' + device.unit + ' - ' + device.name
      }
    end
    obj = {
      "results": result
    }
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end
   
  def query_list
    _start = params[:start].gsub(/\s/, '')
    _end = params[:end].gsub(/\s/, '')
    fct = params[:fct].gsub(/\s/, '')

    items = SignLog.where(:sign_date => [_start.._end], :device_id => iddecode(fct)) 
   
    obj = []
    items.each_with_index do |item, index|
      obj << {
        #:factory => idencode(factory.id),
        #:id => idencode(item.id),
        :id => index + 1, 

        :sign_date => item.sign_date,
       
        :wx_user_id => WxUser.find(item.wx_user_id).name,
       
        :device_id => Device.find(item.device_id).name,

        :avatar => "<img class='h-100px' src='#{item.avatar_url}' />"
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end


end
