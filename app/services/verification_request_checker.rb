class VerificationRequestChecker
  def initialize(request_id, code)
    @result = SMSClient.new.check_verification(request_id, code)
  end

  def phone_number_confirmed?
    @result.status == '0'
  end

  def error_text
    @result.error_text
  end
end
