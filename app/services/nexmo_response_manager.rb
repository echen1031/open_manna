class NexmoResponseManager
  def initialize(nexmo_response)
    messages = nexmo_response.messages.first
    @nexmo_response = messages
  end

  def successful
    status_code == "0"
  end

  def throttled
    status_code == "1"
  end

  def status_code
    @nexmo_response.status
  end

  def error_text
    @nexmo_response.error_text
  end

  def status_text
    successful ? "Success" : error_text
  end

  def message_id
    successful ? @nexmo_response.message_id : "N/A"
  end

  def to
    successful ? @nexmo_response.to : "N/A"
  end
end
