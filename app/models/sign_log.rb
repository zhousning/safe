class SignLog < ActiveRecord::Base

  mount_uploader :avatar, EnclosureUploader






  belongs_to :worker



end

# == Schema Information
#
# Table name: sign_logs
#
#  id          :integer         not null, primary key
#  sign_date   :date
#  wx_user_id  :integer         default("0"), not null
#  device_id   :integer         default("0"), not null
#  avatar      :string          default(""), not null
#  avatar_base :text
#  worker_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

