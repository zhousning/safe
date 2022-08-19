class InventoriesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
   
    @factory = my_factory
    @inventories = @factory.inventories.order('created_at DESC').page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  #def query_all 
  #  items = Inventory.all
  # 
  #  obj = []
  #  items.each do |item|
  #    obj << {
  #      #:factory => idencode(factory.id),
  #      :id => idencode(item.id),
  #     
  #      :name => item.name,
  #     
  #      :desc => item.desc,
  #     
  #      :palce => item.palce
  #    
  #    }
  #  end
  #  respond_to do |f|
  #    f.json{ render :json => obj.to_json}
  #  end
  #end



   
  def show
   
    @factory = my_factory
    @inventory = @factory.inventories.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @factory = my_factory
    @inventory = Inventory.new
    
    @inventory.inventory_items.build
    
  end
   

   
  def create
    @factory = my_factory
    @inventory = Inventory.new(inventory_params)
     
    @inventory.factory = @factory
     
    if @inventory.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @factory = my_factory
    @inventory = @factory.inventories.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @factory = my_factory
    @inventory = @factory.inventories.find(iddecode(params[:id]))
   
    if @inventory.update(inventory_params)
      redirect_to factory_inventory_path(idencode(@factory.id), idencode(@inventory.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @factory = my_factory
    @inventory = @factory.inventories.find(iddecode(params[:id]))
   
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

