class AddUserIdToSubscriptionVerse < ActiveRecord::Migration
  def change
    add_column :subscription_verses, :user_id, :integer
  end
end
