class RemoveNameAndExternalIdFromPlan < ActiveRecord::Migration[5.2]
  def change
    remove_column :plans, :name, :string
    remove_column :plans, :external_id, :string
    remove_column :plans, :subscription_limit, :integer
  end
end
