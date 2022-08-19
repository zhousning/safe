class InventoryItemsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @inventory_item = InventoryItem.new
   
    #@inventory_items = InventoryItem.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = InventoryItem.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :content => item.content,
       
        :method => item.method,
       
        :ctg => item.ctg,
       
        :state => item.state,
       
        :place => item.place
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @inventory_item = InventoryItem.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @inventory_item = InventoryItem.new
    
  end
   

   
  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
     
    if @inventory_item.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @inventory_item = InventoryItem.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @inventory_item = InventoryItem.find(iddecode(params[:id]))
   
    if @inventory_item.update(inventory_item_params)
      redirect_to inventory_item_path(idencode(@inventory_item.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @inventory_item = InventoryItem.find(iddecode(params[:id]))
   
    @inventory_item.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def inventory_item_params
      params.require(:inventory_item).permit( :name, :content, :method, :ctg, :state, :place)
    end
  
  
  
end

