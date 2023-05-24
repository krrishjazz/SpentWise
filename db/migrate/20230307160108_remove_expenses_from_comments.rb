class RemoveExpensesFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :expense, null: false, foreign_key: true
  end
end
