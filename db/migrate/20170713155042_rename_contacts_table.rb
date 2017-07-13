class RenameContactsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :contacts, :user_contacts
  end
end
