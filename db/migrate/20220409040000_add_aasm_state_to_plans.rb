class AddAasmStateToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :aasm_state, :string
  end
end
