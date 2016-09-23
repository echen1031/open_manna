class Subscription < ActiveRecord::Base
  belongs_to :user
  has_many :subscription_verses
  has_many :verses, through: :subscription_verses

  validates :name, :user_id, :time_zone, :phone_number, :send_hour, presence: true
  validates :phone_number, phone_number_format: true
  phony_normalize :phone_number, default_country_code: 'US'

  scope :active, -> { where(active: true) }

  def no_sms_for_today
    self.send(current_day_in_words) == false
  end

  def new_subscription?
    self.user.number_of_verses_received == 0
  end

  def current_day_in_words
    Time.use_zone(self.time_zone) do
      current_day = Time.zone.now.strftime("%A").downcase
      return "send_#{current_day}"
    end
  end
end
