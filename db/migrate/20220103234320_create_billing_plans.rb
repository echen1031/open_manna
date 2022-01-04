class CreateBillingPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_plans do |t|
      t.bigint :billing_product_id, null: false
      t.string :stripe_id, null: false
      t.string :stripe_plan_name
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
