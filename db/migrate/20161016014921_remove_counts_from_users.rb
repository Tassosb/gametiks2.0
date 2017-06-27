class RemoveCountsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :bear_count, :integer
    remove_column :users, :moose_count, :integer
    remove_column :users, :deer_count, :integer
    remove_column :users, :turkey_count, :integer
  end
end
