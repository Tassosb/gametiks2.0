class AddDeerCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deer_count, :integer
  end
end
