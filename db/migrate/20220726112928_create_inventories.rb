class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.text :desc
    
      t.string :palce,  null: false, default: Setting.systems.default_str
    

    

    

    
      t.references :factory
    

    
      t.references :user
    
      t.timestamps null: false
    end
  end
end
