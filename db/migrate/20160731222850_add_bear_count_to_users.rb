class AddBearCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bear_count, :integer
  end
end
