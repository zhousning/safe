class OutReview < ActiveRecord::Base



  mount_uploader :official, AttachmentUploader

  mount_uploader :result, AttachmentUploader

  mount_uploader :modified, AttachmentUploader

  mount_uploader :recheck, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



end
