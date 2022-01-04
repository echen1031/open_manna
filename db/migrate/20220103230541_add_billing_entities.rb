class AddBillingEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_products do |t|
      t.string :stripe_id, null: false
      t.string :stripe_product_name, null: false

      t.timestamps
    end

    create_table :billing_customers do |t|
      t.references :user

      t.string :stripe_id, null: false
      t.string :default_source

      t.timestamps
    end
  end
end
