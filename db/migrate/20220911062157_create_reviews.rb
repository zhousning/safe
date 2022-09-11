class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.date :search_date
    
      t.text :content
    
      t.string :state,  null: false, default: Setting.states.created
    
      t.string :desc1,  null: false, default: Setting.systems.default_str
    
      t.string :desc2,  null: false, default: Setting.systems.default_str
    

    

    
      t.string :attch,  null: false, default: Setting.systems.default_str
    

    
      t.references :grp_review
    
      t.references :factory
    

    
      t.timestamps null: false
    end
  end
end
