class Subscription < ActiveRecord::Base
  belongs_to :user
  EARLIEST_HOUR = 6
  LASTEST_HOUR = 21
  RANDOM_HOUR = 99

  validates :user_id, :time_zone, :phone_number, :send_hour, presence: true
  validates :phone_number, phone_number_format: true
  phony_normalize :phone_number, default_country_code: 'US'

  def no_sms_for_today
    self.send(current_day_in_words) == false
  end

  def current_day_in_words
    Time.use_zone(self.time_zone) do
      current_day = Time.zone.now.strftime("%A").downcase
      return "send_#{current_day}"
    end
  end
end
