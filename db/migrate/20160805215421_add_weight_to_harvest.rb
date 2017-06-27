class AddWeightToHarvest < ActiveRecord::Migration
  def change
    add_column :harvests, :weight, :integer
  end
end
