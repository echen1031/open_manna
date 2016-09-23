class DailySMSWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    sub = Subscription.find(subscription_id)
    user_id = sub.user.id
    phone_number = sub.phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    nexmo_response = NexmoResponseManager.new(response)
    log_nexmo_response(nexmo_response)
    if nexmo_response.successful
      SubscriptionVerse.create(subscription_id: subscription_id, verse_id: verse_id, user_id: user_id)
    elsif nexmo_response.throttled
      resend_message(subscription_id, verse_id) 
    end
  end
end

def resend_message(sub_id, verse_id)
  random_interval = rand(2..60).seconds
  DailySMSWorker.perform_in(random_interval, sub_id, verse_id)
end

def log_nexmo_response(nexmo_response)
  SMSClientLogger.create(status_code: nexmo_response.status_code, 
                         status_text: nexmo_response.status_text, 
                         message_id: nexmo_response.message_id, 
                         to: nexmo_response.to)
end
