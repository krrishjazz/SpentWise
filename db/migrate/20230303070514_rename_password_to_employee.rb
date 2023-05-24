class RenamePasswordToEmployee < ActiveRecord::Migration[7.0]
  def change
    rename_column :employees, :password_bigest, :password_digest
  end
end
