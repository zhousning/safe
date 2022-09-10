class Summary < ActiveRecord::Base



  mount_uploader :attach, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



  belongs_to :user

end

# == Schema Information
#
# Table name: summaries
#
#  id         :integer         not null, primary key
#  title      :string          default(""), not null
#  content    :text
#  place      :string          default(""), not null
#  start_date :date
#  end_date   :date
#  attach     :string          default(""), not null
#  factory_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

