class CreateBillingSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_subscriptions do |t|
      t.bigint :billing_plan_id, null: false
      t.bigint :billing_customer_id, null: false
      t.string :stripe_id, null: false
      t.string :status, nul: false
      t.datetime :current_period_end
      t.datetime :cancel_at

      t.timestamps
    end
  end
end
