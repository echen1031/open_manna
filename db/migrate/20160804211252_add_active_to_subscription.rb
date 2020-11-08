class AddActiveToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :active, :boolean, null: false, default: false
  end
end
