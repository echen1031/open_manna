module SubscriptionsHelper
  EARLIEST_HOUR = 6
  LATEST_HOUR = 21
  RANDOM_HOUR = 99

  def select_hours
    [['Random (8 am ~ 8 pm)', RANDOM_HOUR]] + 
      (EARLIEST_HOUR..LATEST_HOUR).map {|h| [Time.parse("#{h}:00").strftime("%l %P"), h ] }
  end 
end
