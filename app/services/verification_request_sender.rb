class VerificationRequestSender
  def initialize(number)
    @result = SMSClient.new.send_verification(number)
  end

  def send_successful_request?
    @result.status == "0"
  end

  def request_id
    @result.request_id
  end
end
