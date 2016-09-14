class DailySmsWorker
  include Sidekiq::Worker

  def perform(subscription_id, verse_id)
    raise 'invalid request' if subscription_id.nil? or verse_id.nil?
    phone_number = Subscription.find(subscription_id).phone_number
    bible_verse = VerseDecorator.decorate(Verse.find(verse_id))
    response = SMSClient.new.send_message(to: phone_number, text: bible_verse.text_message)
    if response['status'] == '0'
      puts "Sent message #{response['message-id']}"

      puts "Remaining balance is #{response['remaining-balance']}"
    else
      puts "Error: #{response['error-text']}"
    end
  end
end
