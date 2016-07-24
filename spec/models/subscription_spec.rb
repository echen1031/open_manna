require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :time_zone }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :send_hour }
  end

  describe "Scopes" do
    describe "with_sms_to_send_today" do
      it "collects all the subscriptions that checked for monday" do
        Timecop.travel("2016-07-11") #Monday/day_1
        monday_sub = create(:subscription, send_monday: true, send_hour: 7, time_zone: "Eastern Time (US & Canada)")
        tuesday_sub = create(:subscription, send_tuesday: true, send_hour: 7, time_zone: "Eastern Time (US & Canada)")
        monday_and_tuesady_sub = create(:subscription, send_monday: true, send_tuesday: true, send_hour: 7, time_zone: "Eastern Time (US & Canada)")

        result = Subscription.with_sms_to_send_today
        expect(result).to include monday_sub, monday_and_tuesday_sub
        expect(result).not_to include tuesday_sub

        Timecop.return
      end
    end
  end
end
