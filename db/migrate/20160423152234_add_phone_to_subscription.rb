class AddPhoneToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :phone, :string
  end
end
