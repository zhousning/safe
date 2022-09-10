class FctWxuser < ActiveRecord::Base
  belongs_to :factory
  belongs_to :wx_user
end

# == Schema Information
#
# Table name: fct_wxusers
#
#  id         :integer         not null, primary key
#  factory_id :integer
#  wx_user_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

