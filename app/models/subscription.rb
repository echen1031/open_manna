class Subscription < ActiveRecord::Base
  belongs_to :user
  EARLIEST_HOUR = 5
  LASTEST_HOUR = 23
  RANDOM_HOUR = 99

  validates :user_id, :time_zone, :phone, :send_hour, presence: true
end
