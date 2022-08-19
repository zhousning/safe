class Inventory < ActiveRecord::Base






  has_many :inventory_items, :dependent => :destroy
  accepts_nested_attributes_for :inventory_items, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory



  belongs_to :user

end
