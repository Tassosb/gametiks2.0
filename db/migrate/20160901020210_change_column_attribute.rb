class ChangeColumnAttribute < ActiveRecord::Migration
  def change
    change_column :harvests, :latitude, :string
    change_column :harvests, :longitude, :string
  end
end
