class DailySMSWorker
  include Sidekiq::Worker

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    sub = Subscription.find(subscription_id)
    phone_number = sub.phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    nexmo_response = NexmoResponseManager.new(response)
    log_nexmo_response(nexmo_response)
    record_subscription_verse(subscription_id, verse_id, sub.user.id) if nexmo_resopnse.successful
    resend_message(subscription_id, verse_id) if nexmo_response.throttled
  end

  def resend_message(sub_id, verse_id)
    random_interval = rand(2..60).seconds
    DailySMSWorker.perform_in(random_interval, sub_id, verse_id)
  end

  def record_subscription_verse(sub_id, verse_id, user_id)
    SubscriptionVerse.create(subscription_id: sub_id, verse_id: verse_id, user_id: user_id)
  end

  def log_nexmo_response(nexmo_response)
    SMSClientLogger.create(status_code: nexmo_response.status_code, 
                           status_text: nexmo_response.status_text, 
                           message_id: nexmo_response.message_id, 
                           to: nexmo_response.to)
  end
end
