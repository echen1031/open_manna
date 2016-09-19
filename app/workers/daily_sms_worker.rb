class DailySmsWorker
  include Sidekiq::Worker

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    phone_number = Subscription.find(subscription_id).phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    if response['status'] == '0'
      SubscriptionVerse.create(subscription_id: subscription_id, verse_id: verse_id)
      SmsClientLogger.create(status_code: response['status'], status_text: "Success", message_id: response['message-id'], to: response['to'])
    else
      SmsClientLogger.create(status_code: response['status'], status_text: "Error: #{response['error-text']}", message_id: "N/A", to: "N/A")
    end
  end
end
