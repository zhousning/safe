class GrpInventoriesController < ApplicationController
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
      items = fct.inventories.where(:search_date => [_start.._end]) 
      items.each_with_index do |item, index|
        obj << {
          :id => index + 1,
          :fct_id  => idencode(fct.id), 
          :button => "<button class = 'button button-royal button-small mr-1 log-show-btn' type = 'button' data-id ='" + idencode(item.id).to_s + "'>modal弹窗</button>",

         
          :name => item.name,
         
          :desc => item.desc,
         
          :palce => item.palce
        
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_info 
    inventory = Inventory.find(iddecode(params[:id]))
    obj = []
    obj << {
      :time => inventory.created_at.strftime('%Y-%m-%d %H:%M:%S'),
       
        :name => inventory.name,
       
        :desc => inventory.desc,
       
        :palce => inventory.palce
      
    }
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end


   
  def index
     
    @factories = Factory.all
     
    @inventories = Inventory.all.page( params[:page]).per( Setting.systems.per_page )
  end
   

  def query_all 
    items = Inventory.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :desc => item.desc,
       
        :palce => item.palce
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
    @inventory = Inventory.find(iddecode(params[:id]))
  end
   

   
  def new
    @inventory = Inventory.new
    
    @inventory.inventory_items.build
    
  end
   

   
  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
    @inventory = Inventory.find(iddecode(params[:id]))
  end
   

   
  def update
    @inventory = Inventory.find(iddecode(params[:id]))
    if @inventory.update(inventory_params)
      redirect_to inventory_path(idencode(@inventory.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @inventory = Inventory.find(iddecode(params[:id]))
    @inventory.destroy
    redirect_to :action => :index
  end
   

  

  

  
  def xls_download
    send_file File.join(Rails.root, "templates", "表格模板.xlsx"), :filename => "表格模板.xlsx", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  

  private
    def inventory_params
      params.require(:inventory).permit( :name, :desc, :palce, inventory_items_attributes: inventory_item_params)
    end
  
  
  
    def inventory_item_params
      [:id, :name, :content, :method, :ctg, :status, :place ,:_destroy]
    end
  
end

