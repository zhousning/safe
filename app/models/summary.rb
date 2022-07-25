class Summary < ActiveRecord::Base



  mount_uploader :attach, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



  belongs_to :user

end
