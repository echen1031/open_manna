class SMSClient
  require 'nexmo'

  def initialize
    @client = Nexmo::Client.new(key: ENV['NEXMO_API_KEY'],
                                    secret: ENV['NEXMO_API_SECRET'])
  end

  def send_message(from:, to:, text:)
    @client.send_message(from: from, to: to, text: text)
  end
end
