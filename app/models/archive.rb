class Archive < ActiveRecord::Base

  has_many :portfolios, :dependent => :destroy
  accepts_nested_attributes_for :portfolios, reject_if: :all_blank, allow_destroy: true


  belongs_to :factory

end


# == Schema Information
#
# Table name: archives
#
#  id         :integer         not null, primary key
#  name       :string          default(""), not null
#  desc       :string          default(""), not null
#  factory_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

