class CreatePlan < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :status
      t.string :external_id
      t.integer :subscription_limit
      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
