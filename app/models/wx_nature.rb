class WxNature < ActiveRecord::Base
  belongs_to :wx_template


end



# == Schema Information
#
# Table name: wx_natures
#
#  id             :integer         not null, primary key
#  name           :string
#  data_type      :string
#  title          :string
#  tag            :string
#  required       :boolean
#  wx_template_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

