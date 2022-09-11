class GrpReview < ActiveRecord::Base



  mount_uploader :attch, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  has_many :reviews, :dependent => :destroy
  accepts_nested_attributes_for :reviews, reject_if: :all_blank, allow_destroy: true

  STATESTR = %w(opening published)
  STATE = [Setting.states.opening, Setting.states.published]
  validates_inclusion_of :state, :in => STATE
  state_hash = {
    STATESTR[0] => Setting.states.opening, 
    STATESTR[1] => Setting.states.published
  }

  STATESTR.each do |state|
    define_method "#{state}?" do
      self.state == state_hash[state]
    end
  end

  def opening 
    update_attribute :state, Setting.states.opening
  end

  def published
    update_attribute :state, Setting.states.published
  end


end
