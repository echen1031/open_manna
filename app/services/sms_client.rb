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
    @client.send_message(from: @from, to: to, text: text)
  end

  def send_welcome_message(to:)
    @client.send_message(from: @from, to: to, text: @welcome_text)
  end

  def send_verification(number)
    @client.start_verification(number: number, brand: "OpenManna")
  end

  def check_verification(request_id, code)
    @client.check_verification(request_id, code: code)
  end
end
