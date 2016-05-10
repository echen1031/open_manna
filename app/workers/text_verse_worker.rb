class TextVerseWorker
  include Sidekiq::Worker
  require 'nexmo'

  def perform(subscription_id, verse_id)
    subscription = Subscription.find(subscription_id)
    verse = Verse.find(verse_id)

    nexmo = Nexmo::Client.new(key: ENV['NEXMO_API_KEY'], secret: ENV['NEXMO_API_SECRET'])
    response = nexmo.send_message(from: 'Open Manna', to: subscription.phone, text: verse.text)

    if response['messages'][0]['status'].zero?
      puts "Sent message successfully"
    else
      raise response.error
    end
  end

end
