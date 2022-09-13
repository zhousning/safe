class Review < ActiveRecord::Base



  mount_uploader :attch, AttachmentUploader



  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true


  belongs_to :grp_review


  belongs_to :factory

  has_one :review_result, :dependent => :destroy
  has_one :modify_result, :dependent => :destroy
  has_one :recheck_result, :dependent => :destroy

  #has_many :review_results, :dependent => :destroy
  #accepts_nested_attributes_for :review_results, reject_if: :all_blank, allow_destroy: true


  #has_many :modify_results, :dependent => :destroy
  #accepts_nested_attributes_for :modify_results, reject_if: :all_blank, allow_destroy: true


  #has_many :recheck_results, :dependent => :destroy
  #accepts_nested_attributes_for :recheck_results, reject_if: :all_blank, allow_destroy: true


  STATESTR = %w(created modifying modified review report reject completed good)
  STATE = [Setting.states.created, Setting.states.modifying, Setting.states.modified, Setting.states.review, Setting.states.report, Setting.states.reject, Setting.states.completed, Setting.states.good ]
  validates_inclusion_of :state, :in => STATE
  state_hash = {
    STATESTR[0] => Setting.states.created, 
    STATESTR[1] => Setting.states.modifying,
    STATESTR[2] => Setting.states.modified, 
    STATESTR[3] => Setting.states.review, 
    STATESTR[4] => Setting.states.report, 
    STATESTR[5] => Setting.states.reject, 
    STATESTR[6] => Setting.states.completed, 
    STATESTR[7] => Setting.states.good 
  }

  STATESTR.each do |state|
    define_method "#{state}?" do
      self.state == state_hash[state]
    end
  end

  def created 
    update_attribute :state, Setting.states.created
  end

  def modifying 
    if created? || reject?
      update_attribute :state, Setting.states.modifying
    end
  end

  def modified
    if modifying? || review? || reject?
      update_attribute :state, Setting.states.modified
    end
  end

  def review
    if modified? || review?
      update_attribute :state, Setting.states.review
    end
  end

  def report
    if review?
      update_attribute :state, Setting.states.report
    end
  end

  def reject
    if report?
      update_attribute :state, Setting.states.reject
    end
  end

  def completed
    if report?
      update_attribute :state, Setting.states.completed
    end
  end

  def good
    if created?
      update_attribute :state, Setting.states.good
    end
  end

  before_create :build_default_data
  def build_default_data
    build_review_result
    build_modify_result
    build_recheck_result
  end

end
