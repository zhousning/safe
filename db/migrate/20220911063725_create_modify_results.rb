class CreateModifyResults < ActiveRecord::Migration
  def change
    create_table :modify_results do |t|
    
      t.string :worker,  null: false, default: Setting.systems.default_str
    
      t.string :signer,  null: false, default: Setting.systems.default_str
    
      t.date :search_date
    
      t.integer :number,  null: false, default: Setting.systems.default_num 
    
      t.text :content
    

    

    
      t.string :attach,  null: false, default: Setting.systems.default_str
    
      t.string :idattach,  null: false, default: Setting.systems.default_str
    

    
      t.references :review
    

    
      t.timestamps null: false
    end
  end
end
