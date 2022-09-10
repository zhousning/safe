class Worker < ActiveRecord::Base

  mount_uploader :avatar, EnclosureUploader

  mount_uploader :idfront, EnclosureUploader

  mount_uploader :idback, EnclosureUploader


  has_many :sign_logs, :dependent => :destroy

  before_save :store_unique_number
  def store_unique_number
    if self.number == ""
      self.number = Time.now.to_i.to_s + "%04d" % [rand(10000)]
    end
  end

  STATE = [Setting.states.ongoing, Setting.states.completed, Setting.states.canceled, Setting.states.processing]
  validates_inclusion_of :state, :in => STATE

  def ongoing 
    update_attribute :state, Setting.states.ongoing
  end

  def completed
    update_attribute :state, Setting.states.completed
  end

  def canceled
    update_attribute :state, Setting.states.canceled
  end

  def processing 
    update_attribute :state, Setting.states.processing
  end

end

# == Schema Information
#
# Table name: workers
#
#  id          :integer         not null, primary key
#  name        :string          default(""), not null
#  idno        :string          default(""), not null
#  phone       :string          default(""), not null
#  gender      :string          default(""), not null
#  state       :string          default("ongoing"), not null
#  adress      :string          default(""), not null
#  desc        :string          default(""), not null
#  number      :string          default(""), not null
#  avatar      :string          default(""), not null
#  idfront     :string          default(""), not null
#  idback      :string          default(""), not null
#  avatar_base :text
#  img         :text
#  wx_inviter  :integer
#  factory     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

