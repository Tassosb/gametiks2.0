class DropAuthorizations < ActiveRecord::Migration[5.0]
  def change
    drop_table :authorizations
  end
end
