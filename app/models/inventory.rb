class Inventory < ActiveRecord::Base






  has_many :inventory_items, :dependent => :destroy
  accepts_nested_attributes_for :inventory_items, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



  belongs_to :user

end

# == Schema Information
#
# Table name: inventories
#
#  id         :integer         not null, primary key
#  name       :string          default(""), not null
#  desc       :text
#  palce      :string          default(""), not null
#  factory_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

