class SMSClient
  require 'nexmo'

  def initialize
    @client = Nexmo::Client.new(key: ENV['NEXMO_API_KEY'],
                                    secret: ENV['NEXMO_API_SECRET'])
    @from = ENV['NEXMO_PHONE']
  end

  def send_message(to:, text:)
    @client.send_message(from: @from, to: to, text: text)
  end
end
