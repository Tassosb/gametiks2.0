class AddCreditsCountToHarvest < ActiveRecord::Migration[5.0]
  def change
    add_column :harvests, :credits_count, :integer, default: 0
  end
end
