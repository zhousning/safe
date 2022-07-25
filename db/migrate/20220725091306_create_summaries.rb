class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :content
    
      t.string :place,  null: false, default: Setting.systems.default_str
    

    

    
      t.string :attach,  null: false, default: Setting.systems.default_str
    

    
      t.references :factory
    

    
      t.timestamps null: false
    end
  end
end
