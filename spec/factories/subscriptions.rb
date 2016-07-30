require 'faker'

FactoryGirl.define do
  factory :subscription do
    sequence(:user_id) { |n| n }
    name { Faker::Name.name }
    send_hour 7
    time_zone "Eastern Time (US & Canada)"
    phone "15555555555"
  end
end
