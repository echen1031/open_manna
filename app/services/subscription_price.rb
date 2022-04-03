require "ostruct"

class SubscriptionPrice
  YEARLY_5 = OpenStruct.new({
    id: ENV['YEARLY_PRICE_ID'],
    name: "yearly-5",
    amount: 500,
    currency: "usd",
    interval: "year",
  })

  def self.current_yearly
    YEARLY_5
  end
end
