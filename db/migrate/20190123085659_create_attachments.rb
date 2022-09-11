class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.timestamps null: false

      t.string :file,  null: false, default: ""
      t.references :train
      t.references :drill
      t.references :summary
      t.references :grp_review
      t.references :review
      t.references :review_result
      t.references :modify_result
      t.references :recheck_result
    end
  end
end
