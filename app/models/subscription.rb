class Subscription < ActiveRecord::Base
  belongs_to :user
  EARLIEST_HOUR = 5
  LASTEST_HOUR = 23
  RANDOM_HOUR = 99
  DAYS_CONVERTER = {
    1 => "send_monday",
    2 => "send_tuesday",
    3 => "send_wednesday",
    4 => "send_thursday",
    5 => "send_friday",
    6 => "send_saturday",
    0 => "send_sunday"
  }


  validates :user_id, :time_zone, :phone, :send_hour, presence: true

  def no_sms_for_today
    current_day = Time.now.wday
    self.send(DAYS_CONVERTER[current_day]) == false
  end
end
