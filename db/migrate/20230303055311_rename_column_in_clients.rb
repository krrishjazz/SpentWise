class RenameColumnInClients < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :passoword_digest, :password_digest
  end
end
