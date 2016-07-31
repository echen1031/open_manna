class ChangePhoneToPhoneNumber < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :phone, :phone_number
  end
end
