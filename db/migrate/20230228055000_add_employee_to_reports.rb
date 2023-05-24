class AddEmployeeToReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :employee, null: false, foreign_key: true
  end
end
