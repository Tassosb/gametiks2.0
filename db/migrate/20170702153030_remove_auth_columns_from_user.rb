class RemoveAuthColumnsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :password_digest
    remove_column :users, :remember_digest
    remove_column :users, :activation_digest
    remove_column :users, :activated
    remove_column :users, :activated_at
    remove_column :users, :street_address
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zipcode
    remove_column :users, :provider
    remove_column :users, :uid 
  end
end
