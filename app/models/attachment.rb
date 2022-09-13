class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentUploader
  belongs_to :train
  belongs_to :drill
  belongs_to :summary
  belongs_to :grp_review
  belongs_to :review
  belongs_to :review_result
  belongs_to :modify_result
  belongs_to :recheck_result
  belongs_to :out_review
  belongs_to :out_review
end






# == Schema Information
#
# Table name: attachments
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  file       :string          default(""), not null
#  train_id   :integer
#  drill_id   :integer
#  summary_id :integer
#

