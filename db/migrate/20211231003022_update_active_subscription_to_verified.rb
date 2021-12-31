class UpdateActiveSubscriptionToVerified < ActiveRecord::Migration[5.2]
  def change
    Subscriptionactive.each do |s|
      s.update_columns(verified: true)
    end
  end
end
