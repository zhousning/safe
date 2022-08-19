class Examine < ActiveRecord::Base

  belongs_to :factory

  belongs_to :grp_examine

  has_many :exm_items, :dependent => :destroy
  accepts_nested_attributes_for :exm_items, reject_if: :all_blank, allow_destroy: true

  has_many :documents, :dependent => :destroy
  accepts_nested_attributes_for :documents, reject_if: :all_blank, allow_destroy: true

  STATESTR = %w(opening report)
  STATE = [Setting.states.opening, Setting.states.report]
  validates_inclusion_of :state, :in => STATE
  state_hash = {
    STATESTR[0] => Setting.states.opening, 
    STATESTR[1] => Setting.states.report
  }

  STATESTR.each do |state|
    define_method "#{state}?" do
      self.state == state_hash[state]
    end
  end

  def opening 
    update_attribute :state, Setting.states.opening
  end

  def report
    update_attribute :state, Setting.states.report
  end
end

# == Schema Information
#
# Table name: examines
#
#  id         :integer         not null, primary key
#  name       :string          default(""), not null
#  hierarchy  :text
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

