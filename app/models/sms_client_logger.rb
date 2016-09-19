class SMSClientLogger < ActiveRecord::Base
  validates :status_code, presence: true
  validates :status_text, presence: true
  validates :message_id, presence: true
  validates :to, presence: true
end
