class AddLatitudeToHarvests < ActiveRecord::Migration
  def change
    add_column :harvests, :latitude, :decimal
    add_column :harvests, :longitude, :decimal
  end
end
