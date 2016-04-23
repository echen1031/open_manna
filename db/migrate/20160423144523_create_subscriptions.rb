class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.boolean :send_day_1
      t.boolean :send_day_2
      t.boolean :send_day_3
      t.boolean :send_day_4
      t.boolean :send_day_5
      t.boolean :send_day_6
      t.boolean :send_day_7
      t.integer :send_hour
      t.string :time_zone

      t.timestamps null: false
    end
  end
end
