class WxUser < ActiveRecord::Base

  has_many :fct_wxusers, :dependent => :destroy
  has_many :factories, :through => :fct_wxusers

  has_many :device_wxusers, :dependent => :destroy
  has_many :devices, :through => :device_wxusers

 STATESTR = %w(ongoing completed)
  STATE = [Setting.states.ongoing, Setting.states.completed]
  validates_inclusion_of :state, :in => STATE
  state_hash = {
    STATESTR[0] => Setting.states.ongoing, 
    STATESTR[5] => Setting.states.completed
  }

  STATESTR.each do |state|
    define_method "#{state}?" do
      self.state == state_hash[state]
    end
  end

  def ongoing 
    update_attribute :state, Setting.states.ongoing
  end

  def completed
    update_attribute :state, Setting.states.completed
  end

end

# == Schema Information
#
# Table name: wx_users
#
#  id         :integer         not null, primary key
#  unionid    :string          default(""), not null
#  openid     :string          default(""), not null
#  name       :string          default(""), not null
#  phone      :string          default(""), not null
#  nickname   :string          default(""), not null
#  avatarurl  :string          default(""), not null
#  gender     :string          default(""), not null
#  city       :string          default(""), not null
#  province   :string          default(""), not null
#  country    :string          default(""), not null
#  language   :string          default(""), not null
#  state      :string          default("ongoing"), not null
#  task_state :string          default("pending"), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

