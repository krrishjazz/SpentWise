class ChangeNullInExpenses < ActiveRecord::Migration[7.0]
  def change
    change_column_null :expenses, :employee_id, true
  end
end
