class AddDatetimeToComments < ActiveRecord::Migration[5.0]
  def change_table
    add_column :comments, :created_at, :datetime, null: false
    add_column :comments, :updated_at, :datetime, null: false
  end
end
