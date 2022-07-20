require 'json'
class WxTemplatesController < ApplicationController
  layout "application_control"
  #load_and_authorize_resource

   
  def index
    @templates = WxTemplate.all
  end
   

   
  def show
    @template = WxTemplate.find(params[:id])
  end
   

   
  def new
    @template = WxTemplate.new
    
    @template.wx_natures.build
    
  end
   

   
  def create
    @template = WxTemplate.new(template_params)
    #@template.user = current_user
    if @template.save
      redirect_to @template
    else
      render :new
    end
  end
   

   
  def edit
    @template = WxTemplate.find(params[:id])
  end
   

   
  def update
    @template = WxTemplate.find(params[:id])
    if @template.update(template_params)
      redirect_to wx_template_path(@template) 
    else
      render :edit
    end
  end

  def produce
    @template = WxTemplate.find(params[:id])
    @wx_natures = @template.wx_natures

    cond = "rails g wx " + @template.name + " "

    unless @wx_natures.blank?
      wx_nature_str = ""
      label = "-l "
      tag = "-t "
      required = "-u "
      @wx_natures.each do |wx_nature|
        wx_nature_str += wx_nature.name + ":" + wx_nature.data_type + " "
        label += wx_nature.title + " "
        tag += wx_nature.tag + " "
        required += wx_nature.required.to_s + " "
      end
      cond += wx_nature_str + label + tag + required + " "
    end

    cond += "-n " + @template.cn_name + " " + 

           "-i " + @template.image.to_s + " " +
           @template.attachment.to_s + " " +
           @template.index.to_s + " " +
           @template.new.to_s + " " +
           @template.edit.to_s + " " +
           @template.show.to_s + " " +
           @template.form.to_s + " " +
           @template.js.to_s + " " +
           @template.scss.to_s + " " +
           @template.upload.to_s + " " +
           @template.download.to_s + " " +
           @template.current_user.to_s + " " +
           @template.admin.to_s + " "
    
    unless @template.one_image.blank?
      cond += "-b " + @template.one_image.to_s + " "
    end
    unless @template.one_attachment.blank?
      cond += "-k " + @template.one_attachment.to_s + " "
    end

    puts cond
    exec cond
    redirect_to template_path(@template) 
  end
   

   
  def destroy
    @template = WxTemplate.find(params[:id])
    @template.destroy
    redirect_to :action => :index
  end
   

  private
    def template_params
      params.require(:wx_template).permit( :name, :cn_name, :nest, :image, :one_image, :one_attachment, :attachment, :index, :new, :edit, :show, :form, :js, :scss, :upload, :download, :admin, :current_user, wx_natures_attributes: wx_nature_params)
    end
  
    def wx_nature_params
      [:id, :name, :title, :tag, :data_type, :required, :_destroy]
    end
  
end

