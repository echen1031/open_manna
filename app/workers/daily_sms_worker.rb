class DailySMSWorker
  include Sidekiq::Worker

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    phone = Subscription.find(subscription_id).phone
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    SMSClient.new.send_message(to: phone, text: bible_verse.text_message)
  end
end
