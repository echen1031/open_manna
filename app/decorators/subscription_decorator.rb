class SubscriptionDecorator < Draper::Decorator
  delegate_all

  def readable_hour
    send_hour == 99 ? "Random" : Time.parse("#{send_hour}:00").strftime("%l %P")
  end

  def readable_phone_number
    phone_number.phony_formatted(format: :international, spaces: '-')
  end

  def subscribed_days
    days = integer_to_days
    days_string = days.map { |d| Date::ABBR_DAYNAMES[d]}.join " / "
    if days_string.include? 'Sun'
      days_string.sub! 'Sun', 'LD'
    else
      days_string
    end
  end

  def status
    active == true ? "Active" : "Inactive"
  end

  private

  def integer_to_days
    (0..6).select {|d| self.send("send_"+Date::DAYNAMES[d].downcase.to_s) }
  end
end
