class DailySMSWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    sub = Subscription.find(subscription_id)
    phone_number = sub.phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    nexmo_response = NexmoResponseManager.new(response)
    if nexmo_response.throttled
      resend_message(subscription_id, verse_id) 
    end
  end
end

def resend_message(sub_id, verse_id)
  random_interval = rand(2..60).seconds
  DailySMSWorker.perform_in(random_interval, sub_id, verse_id)
end

