module SubscriptionsHelper

  def select_hours
    [['Random (8 am ~ 8 pm)', Subscription::RANDOM_HOUR]] + 
      (Subscription::EARLIEST_HOUR..Subscription::LASTEST_HOUR).map {|h| [Time.parse("#{h}:00").strftime("%l %P"), h ] }
  end 
end
