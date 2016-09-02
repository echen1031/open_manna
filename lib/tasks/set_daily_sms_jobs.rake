namespace :daily_sms do
  task set_jobs: :environment do
    SmsScheduler.set_daily_sms_job
  end
end
