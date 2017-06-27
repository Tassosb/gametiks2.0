class AddHarvestToHarvest < ActiveRecord::Migration
  def change
    add_column :harvests, :image, :string
  end
end
