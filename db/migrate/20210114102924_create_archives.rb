class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.string :desc,  null: false, default: Setting.systems.default_str
    

    

    

    
      t.references :factory
    

      t.timestamps null: false
    end
  end
end
