class AddVerifiedToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :verified, :boolean, default: false
  end
end
