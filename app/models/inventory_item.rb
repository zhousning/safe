class InventoryItem < ActiveRecord::Base






  belongs_to :inventory



end

# == Schema Information
#
# Table name: inventory_items
#
#  id           :integer         not null, primary key
#  name         :string          default(""), not null
#  content      :text
#  method       :string          default(""), not null
#  ctg          :string          default(""), not null
#  state        :string          default(""), not null
#  place        :string          default(""), not null
#  inventory_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

