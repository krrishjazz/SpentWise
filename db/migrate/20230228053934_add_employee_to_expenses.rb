class AddEmployeeToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :employee, null: false, foreign_key: true
  end
end
