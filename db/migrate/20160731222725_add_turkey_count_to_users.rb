class AddTurkeyCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :turkey_count, :integer
  end
end
