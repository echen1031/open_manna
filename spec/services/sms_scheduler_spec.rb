require 'rails_helper'

describe SMSScheduler do
  let(:monday_subscription) { create(:subscription, send_monday: true) }
  let(:tuesday_subscription) { create(:subscription, send_tuesday: true) }

  context "Sending text messages" do
    before do
      Timecop.travel("2016-07-11") #Monday
    end

    after do
      Timecop.return
    end

    it "enques text message job" do
      Timecop.travel(1.day)
      monday_subscription
      verse = double(:verse, id: 1)
      allow(Verse).to receive(:random).and_return(verse)

      SMSScheduler.set_daily_sms_job

      expect(DailySMSWorker.jobs.size).to eq 1
    end

    it "does not enques text message job on the wrong day" do
      Timecop.travel(2.day)
      monday_subscription
      verse = double(:verse, id: 1)
      allow(Verse).to receive(:random).and_return(verse)

      SMSScheduler.set_daily_sms_job

      expect(DailySMSWorker.jobs.size).to eq 0
    end
  end
end
