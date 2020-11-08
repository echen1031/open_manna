class SetDefaultForSendDayColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :subscriptions, :send_monday, :boolean, default: false
    change_column :subscriptions, :send_tuesday, :boolean, default: false
    change_column :subscriptions, :send_wednesday, :boolean, default: false
    change_column :subscriptions, :send_thursday, :boolean, default: false
    change_column :subscriptions, :send_friday, :boolean, default: false
    change_column :subscriptions, :send_saturday, :boolean, default: false
    change_column :subscriptions, :send_sunday, :boolean, default: false
  end
end
