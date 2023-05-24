class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :department
      t.integer :phone_number
      t.string :employment_status

      t.timestamps
    end
  end
end
