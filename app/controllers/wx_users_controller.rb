require 'restclient'
require 'json'

class WxUsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :wxuser_exist?, :except => [:update, :get_userid]

  def update 
    wxuser = WxUser.find_by(:openid => params[:id])
    respond_to do |f|
      if wxuser.update(wx_user_params)
        f.json { render :json => {:status => "wxuser update success" }.to_json}
      else
        f.json { render :json => {:status => "wxuser update error"}.to_json}
      end
    end
  end

  def get_userid
    encryptedData = params[:encryptedData]
    iv = params[:iv]
    url = "https://api.weixin.qq.com/sns/jscode2session"
    data = {
      appid: "wxb8a77e86da1077f5", 
      secret: "72a4d35d55f59e29a66fc4ba0c3a2d40",
      js_code: params[:code].to_s,
      grant_type: 'authorization_code'
    }
    response = RestClient.get url, params: data, :accept => :json
    body = JSON.parse(response.body)
    unless body["errcode"]
      openid = body["openid"]
      session_key = body["session_key"]

      @wxuser = WxUser.find_by(:openid => openid)
      unless @wxuser
        @wxuser = WxUser.new(:openid => openid)
        @wxuser.save
      end

      respond_to do |f|
        f.json { render :json => {:state => 'success', :openId => openid }.to_json }
      end
    else
      respond_to do |f|
        f.json { render :json => {:state => 'error' }.to_json }
      end
    end
  end

  def fcts
    factories = Factory.all
    fct_objs = []
    factories.each do |fct|
      fct_objs << fct.name 
    end

    respond_to do |f|
      f.json { render :json => {fcts: fct_objs}.to_json }
    end
  end

  def areas
    @factory = Factory.find_by_name(params[:fct])
    device_objs = []
    devices = @factory.devices.select('mdno').uniq
    devices.each do |device|
      device_objs << device.mdno
    end

    respond_to do |f|
      f.json { render :json => {areas: device_objs}.to_json }
    end
  end

  def streets
    objs = []
    fcts = Device.where(:mdno => params[:area]).select('unit').uniq
    fcts.each do |fct|
      objs << fct.unit
    end
    respond_to do |f|
      f.json { render :json => objs.to_json }
    end
  end

  def sites
    objs = []
    area = params[:area]
    street = params[:street]
    fcts = Device.where(:mdno => area, :unit => street)
    fcts.each do |fct|
      objs << {:value => idencode(fct.id).to_s, :name => fct.name}
    end
    respond_to do |f|
      f.json { render :json => objs.to_json }
    end
  end

  def set_fct
    fcts = params[:sites]
    ids = []
    fcts.each do |fct|
      ids << iddecode(fct)
    end
    devices = Device.where(:id => ids)
    factory = Factory.find_by_name(params[:fct])
    wxuser = WxUser.find_by(:openid => params[:id])
    if wxuser.state != Setting.states.completed
      respond_to do |f|
        if wxuser.update_attributes(:state => Setting.states.ongoing, :factories => [factory], :devices => devices, :name => params[:name], :phone => params[:phone] )
          f.json { render :json => {:status => "success" }.to_json}
        else
          f.json { render :json => {:status => "error"}.to_json}
        end
      end
    end
  end

  def status
    wxuser = WxUser.find_by(:openid => params[:id])
    devices = wxuser.devices
    device_name = ""
    devices.each do |d|
      device_name += d.name + " "
    end
    respond_to do |f|
      if wxuser.state == Setting.states.ongoing
        f.json { render :json => {:status => Setting.states.ongoing }.to_json}
      else
        owner = wxuser.factories.first.name
        f.json { render :json => {:status => Setting.states.completed, :name => wxuser.name, :phone => wxuser.phone, :fct => device_name, :owner => owner}.to_json}
      end
    end
  end

  private
    def wx_user_params
      params.require(:wx_user).permit(:nickname, :avatarurl, :gender, :city, :province, :country, :language, :name, :phone)
    end                                  

end
