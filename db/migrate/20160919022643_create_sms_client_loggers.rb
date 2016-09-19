class CreateSmsClientLoggers < ActiveRecord::Migration
  def change
    create_table :sms_client_loggers do |t|
      t.string :status_code
      t.string :status_text
      t.string :message_id
      t.string :to

      t.timestamps null: false
    end
  end
end
