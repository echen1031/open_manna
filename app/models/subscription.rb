class Subscription < ActiveRecord::Base
  belongs_to :user
  EARLIEST_HOUR = 5
  LASTEST_HOUR = 23
  RANDOM_HOUR = 99

  validates :user_id, :time_zone, :phone, :send_hour, presence: true

  def sms_to_send_today?
    check_for_send_day_on_subscription
  end

  def check_for_send_day_on_subscription
    current_day = Time.now.wday
    method_name = build_column_name(current_day)
    self.send(method_name) == true
  end

  def build_column_name(current_day)
    "send_day_" + "#{current_day}"
  end
end
