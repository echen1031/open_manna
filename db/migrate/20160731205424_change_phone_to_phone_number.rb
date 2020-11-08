class ChangePhoneToPhoneNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :subscriptions, :phone, :phone_number
  end
end
