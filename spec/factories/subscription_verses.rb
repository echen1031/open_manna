FactoryGirl.define do
  factory :subscription_verse do
    sequence(:subscription_id) { |n| n }
    sequence(:verse_id) { |n| n }
    sequence(:user_id) { |n| n }
  end
end
