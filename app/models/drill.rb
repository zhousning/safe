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
