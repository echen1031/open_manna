class DailySMSWorker
  include Sidekiq::Worker

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    phone_number = Subscription.find(subscription_id).phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    nexmo_response = NexmoResponseManager.new(response)
    SMSClientLogger.create(status_code: nexmo_response.status_code, status_text: nexmo_response.status_text, message_id: nexmo_response.message_id, to: nexmo_response.to)

    if nexmo_response.successful
      SubscriptionVerse.create(subscription_id: subscription_id, verse_id: verse_id)
    elsif nexmo_response.throttled
      DailySMSWorker.perform_in(2.seconds, subscription_id, verse_id)
    end
  end
end
