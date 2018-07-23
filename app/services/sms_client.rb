class SMSClient
  require 'nexmo'
  WELCOME_TEXT = "Welcome to OpenManna! You will be receiving scheduled verses from this number. Enjoy! - OpenManna.com"

  def initialize
    @client = Nexmo::Client.new(key: ENV['NEXMO_API_KEY'],
                                    secret: ENV['NEXMO_API_SECRET'])
    @from = ENV['NEXMO_PHONE']
    @welcome_text = WELCOME_TEXT
  end

  def send_message(to:, text:)
    @client.sms.send(from: @from, to: to, text: text)
  end

  def send_welcome_message(to:)
    @client.sms.send(from: @from, to: to, text: @welcome_text)
  end

  def send_verification(number)
    @client.verify.request(number: number, brand: "OpenManna")
  end

  def check_verification(request_id, code)
    @client.verify.check(request_id: request_id, code: code)
  end
end
