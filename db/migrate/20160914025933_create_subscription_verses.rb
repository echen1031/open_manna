class CreateSubscriptionVerses < ActiveRecord::Migration
  def change
    create_table :subscription_verses do |t|
      t.references :subscription, index: true, null: false
      t.references :verse, index: true, null: false

      t.timestamps null: false
    end
  end
end
