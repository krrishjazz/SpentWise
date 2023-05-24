class AddPasswordToEmployee < ActiveRecord::Migration[7.0]
  def change
    add_column :employees,:password_bigest, :string
  end
end
