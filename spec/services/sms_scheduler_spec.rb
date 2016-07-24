require 'rails_helper'

describe SmsScheduler do
  let(:monday_subscription) { create(:subscription, send_monday: true, time_zone: "Eastern Time (US & Canada)") }
  let(:tuesday_subscription) { create(:subscription, send_tuesday: true, time_zone: "Eastern Time (US & Canada)") }

  context "Sending text messages" do
    before do
      Timecop.travel("2016-07-11") #Monday
    end

    after do
      Timecop.return
    end

    it "enques text message job" do
      monday_subscription
      verse = double(:verse, id: 1)
      allow(Verse).to receive(:random).and_return(verse)

      SmsScheduler.set_daily_sms_job

      expect(DailySmsWorker.jobs.size).to eq 1
    end

    it "does not enques text message job on the wrong day" do
      tuesday_subscription
      verse = double(:verse, id: 1)
      allow(Verse).to receive(:random).and_return(verse)

      SmsScheduler.set_daily_sms_job

      expect(DailySmsWorker.jobs.size).to eq 0
    end
  end
end
