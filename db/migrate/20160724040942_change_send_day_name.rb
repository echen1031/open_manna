class ChangeSendDayName < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :send_day_1, :send_monday
    rename_column :subscriptions, :send_day_2, :send_tuesday
    rename_column :subscriptions, :send_day_3, :send_wednesday
    rename_column :subscriptions, :send_day_4, :send_thursday
    rename_column :subscriptions, :send_day_5, :send_friday
    rename_column :subscriptions, :send_day_6, :send_saturday
    rename_column :subscriptions, :send_day_7, :send_sunday
  end
end
