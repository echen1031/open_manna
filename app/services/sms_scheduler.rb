class SMS_Scheduler
  def self.set_daily_sms_job(subscription, verse)
    if subscription.sms_to_send_today?
      Time.zone = subscription.time_zone
      user_preferred_time_in_utc = Time.now.change(hour: subscription.send_hour).utc
      DailySMSWorker.perform_at(user_preferred_time_in_utc, subscription.id, verse.id)
    end
  end
end
