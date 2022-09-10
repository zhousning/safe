class DeviceWxuser < ActiveRecord::Base
  belongs_to :device
  belongs_to :wx_user
end

# == Schema Information
#
# Table name: device_wxusers
#
#  id         :integer         not null, primary key
#  device_id  :integer
#  wx_user_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

