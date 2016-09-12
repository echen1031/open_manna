class SmsScheduler
  def self.set_daily_sms_job
    Subscription.all.active.each do |sub|
      next if sub.no_sms_for_today
      @time_to_send = (sub.send_hour == 99 ) ? (8..20).to_a.sample : sub.send_hour
      @sub = sub
      @random_verse = Verse::random

      Time.use_zone(sub.time_zone) do
        user_preferred_time_in_utc = Time.zone.now.change(hour: @time_to_send).utc
        DailySmsWorker.perform_at(user_preferred_time_in_utc, @sub.id, @random_verse.id)
      end
    end
  end
end
