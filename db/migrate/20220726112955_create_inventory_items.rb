class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.text :content
    
      t.string :method,  null: false, default: Setting.systems.default_str
    
      t.string :ctg,  null: false, default: Setting.systems.default_str
    
      t.string :state,  null: false, default: Setting.systems.default_str
    
      t.string :place,  null: false, default: Setting.systems.default_str
    

    

    

    
      t.references :inventory
    

    
      t.timestamps null: false
    end
  end
end
