class AddPlanPeriodEndAtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :plan_period_end, :bigint
  end
end
