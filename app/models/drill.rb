class Drill < ActiveRecord::Base

  mount_uploader :sign, EnclosureUploader

  mount_uploader :scene, EnclosureUploader

  mount_uploader :estimate, EnclosureUploader



  mount_uploader :summary, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



  belongs_to :user

end

# == Schema Information
#
# Table name: drills
#
#  id         :integer         not null, primary key
#  title      :string          default(""), not null
#  content    :text
#  place      :string          default(""), not null
#  train_time :datetime
#  address    :string          default(""), not null
#  people     :string          default("0"), not null
#  sign       :string          default(""), not null
#  scene      :string          default(""), not null
#  estimate   :string          default(""), not null
#  summary    :string          default(""), not null
#  factory_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

