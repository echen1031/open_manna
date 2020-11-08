class AddPhoneToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :phone, :string
  end
end
