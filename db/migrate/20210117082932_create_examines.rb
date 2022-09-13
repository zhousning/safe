class CreateExamines < ActiveRecord::Migration
  def change
    create_table :examines do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.text :hierarchy
    
      t.string :state,  null: false, default: Setting.states.opening
    
      t.string :html_link,  null: false, default: Setting.systems.default_str
    
      t.references :factory

      t.references :grp_examine
    

      t.timestamps null: false
    end
  end
end
