class Enclosure < ActiveRecord::Base
  mount_uploader :file, EnclosureUploader

  belongs_to :ocr
end





# == Schema Information
#
# Table name: enclosures
#
#  id             :integer         not null, primary key
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  file           :string          default(""), not null
#  notice_id      :integer
#  article_id     :integer
#  ocr_id         :integer
#  ctg_mtrl_id    :integer
#  task_id        :integer
#  task_report_id :integer
#

