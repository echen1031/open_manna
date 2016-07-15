require 'faker'

FactoryGirl.define do
  factory :subscription do
    sequence(:user_id) { |n| n }
    send_day_1 true
    send_day_2 false
    send_day_3 false
    send_day_4 false
    send_day_5 false
    send_day_6 false
    send_day_7 false
    send_hour 7
    time_zone { Faker::Address.time_zone }
    phone "15555555555"
  end
end
