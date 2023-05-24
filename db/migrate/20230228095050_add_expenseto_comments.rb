class AddExpensetoComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :expense, null: true, foreign_key: true
  end
end
