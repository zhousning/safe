class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :content
    
      t.string :place,  null: false, default: Setting.systems.default_str
    
      t.datetime :train_time
    
      t.string :address,  null: false, default: Setting.systems.default_str
    

    
      t.string :sign,  null: false, default: Setting.systems.default_str
    
      t.string :scene,  null: false, default: Setting.systems.default_str
    
      t.string :estimate,  null: false, default: Setting.systems.default_str
    
      t.string :paper,  null: false, default: Setting.systems.default_str
    

    
      t.string :wpaper,  null: false, default: Setting.systems.default_str
    

    
      t.references :factory
    

      t.timestamps null: false
    end
  end
end
