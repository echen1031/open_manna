class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :display_name
      t.string :external_id
      t.integer :subscription_limit

      t.timestamps
    end
  end
end
