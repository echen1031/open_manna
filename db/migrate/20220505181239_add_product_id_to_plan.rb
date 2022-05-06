class AddProductIdToPlan < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :product_id, :bigint
  end
end
