class UpdateActiveSubscriptionToVerified < ActiveRecord::Migration[5.2]
  def change
    Subscription.active.each do |s|
      s.update_columns(verified: true)
    end
  end
end
