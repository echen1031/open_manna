class SubscriptionDecorator < Draper::Decorator
  delegate_all

  def readable_hour
    send_hour == 99 ? "Random" : Time.parse("#{send_hour}:00").strftime("%l %P")
  end

  def subscribed_days
    days = integer_to_days
    days.map { |d| Date::ABBR_DAYNAMES[d]}.join " / "
  end

  private

  def integer_to_days
    (0..6).select {|d| self.send("send_"+Date::DAYNAMES[d].downcase.to_s) }
  end
end
