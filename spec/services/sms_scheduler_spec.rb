require 'rails_helper'

describe SMS_Scheduler do
  it "schedules text sending according to the user's preferences" do
    sub = create(:subscription, send_day_1: true, send_hour: 7, time_zone: "Eastern Time (US & Canada)")
    verse = create(:verse)
    Timecop.travel("2016-07-11")
    SMS_Scheduler.set_daily_sms_job(sub, verse)
    expect(DailySMSWorker.jobs.size).to eq 1
    Timecop.return
  end
end
