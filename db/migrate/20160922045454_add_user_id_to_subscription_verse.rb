class AddUserIdToSubscriptionVerse < ActiveRecord::Migration[5.2]
  def change
    add_column :subscription_verses, :user_id, :integer
  end
end
