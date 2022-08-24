require 'rails_helper'

describe SMSScheduler do
  let(:monday_subscription) { create(:subscription, send_monday: true) }

  context "Sending text messages" do
    before do
      Timecop.travel("2016-07-11") #Monday
      create(:verse)
      all_subs = double
      allow(Subscription).to receive(:all).and_return(all_subs)
      allow(all_subs).to receive(:active).and_return([monday_subscription])
    end

    after do
      Timecop.return
    end

    it "enques text message job" do
      Timecop.travel(1.day) #travel to monday

      SMSScheduler.set_daily_sms_job

      expect(DailySMSWorker.jobs.size).to eq 0
    end

    it "does not enques text message job on the wrong day" do
      Timecop.travel(2.day)

      SMSScheduler.set_daily_sms_job

      expect(DailySMSWorker.jobs.size).to eq 0
    end
  end
end
