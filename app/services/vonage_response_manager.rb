class VonageResponseManager
  def initialize(vonage_response)
    messages = vonage_response.messages.first
    @vonage_response = messages
  end

  def successful
    status_code == "0"
  end

  def throttled
    status_code == "1"
  end

  def status_code
    @vonage_response.status
  end

  def error_text
    @vonage_response.error_text
  end

  def status_text
    successful ? "Success" : error_text
  end

  def message_id
    successful ? @vonage_response.message_id : "N/A"
  end

  def to
    successful ? @vonage_response.to : "N/A"
  end
end
