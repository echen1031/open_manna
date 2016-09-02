require 'faker'

FactoryGirl.define do
  factory :subscription do
    sequence(:user_id) { |n| n }
    name { Faker::Name.name }
    send_hour 7
    time_zone "Eastern Time (US & Canada)"
    phone_number "15555555555"
    active false
  end
end
