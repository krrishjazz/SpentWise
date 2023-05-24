class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.integer :invoice_number
      t.date :date
      t.text :description
      t.integer :amount

      t.timestamps
    end
  end
end
