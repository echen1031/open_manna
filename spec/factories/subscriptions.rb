require 'faker'

FactoryGirl.define do
  factory :subscription do
    sequence(:user_id) { |n| n }
    send_hour 7
    time_zone { Faker::Address.time_zone }
    phone "15555555555"
  end
end
