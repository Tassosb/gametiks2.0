class RemoveCreditsFromHarvests < ActiveRecord::Migration[5.0]
  def change
    remove_column :harvests, :credits
  end
end
