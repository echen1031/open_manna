class AddStatusToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :status, :string
    add_column :subscriptions, :external_id, :string
    add_column :subscriptions, :cancel_at_period_end, :boolean, default: false
    add_column :subscriptions, :current_period_start, :datetime
    add_column :subscriptions, :current_period_end, :datetime
  end
end
