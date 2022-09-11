class CreateGrpExamines < ActiveRecord::Migration
  def change
    create_table :grp_examines do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
      t.string :state,  null: false, default: Setting.states.opening

      t.date :search_date

      t.text :content
    
      t.text :hierarchy
    

      t.timestamps null: false
    end
  end
end
