require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :time_zone }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :send_hour }

    it "strips non_numerica_values from phone_number" do
      non_numeric_values = "555-555-5555"
      subscription = build(:subscription, phone_number: non_numeric_values)
      subscription.save
      expect(subscription.phone_number).to eq "+15555555555"
    end
  end

  describe "#active" do
    it "takes all the active subscriptions" do
      create(:inactive_subscription)
      create(:subscription)
      expect(Subscription.active.size).to eq 1
    end
  end
end
