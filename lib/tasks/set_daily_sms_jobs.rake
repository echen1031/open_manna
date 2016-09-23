namespace :daily_sms do
  task set_jobs: :environment do
    SMSScheduler.set_daily_sms_job
  end
end
