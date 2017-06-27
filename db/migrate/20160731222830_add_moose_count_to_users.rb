class AddMooseCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moose_count, :integer
  end
end
