class CreateOutReviews < ActiveRecord::Migration
  def change
    create_table :out_reviews do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.date :search_date
    
      t.text :content
    
      t.string :state,  null: false, default: Setting.systems.default_str
    
      t.string :desc1,  null: false, default: Setting.systems.default_str
    
      t.string :desc2,  null: false, default: Setting.systems.default_str
    

    

    
      t.string :official,  null: false, default: Setting.systems.default_str
    
      t.string :result,  null: false, default: Setting.systems.default_str
    
      t.string :modified,  null: false, default: Setting.systems.default_str
    
      t.string :recheck,  null: false, default: Setting.systems.default_str
    

    
      t.references :factory
    

    
      t.timestamps null: false
    end
  end
end
