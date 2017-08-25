class AddCreditsToHarvests < ActiveRecord::Migration[5.0]
  def change
    add_column :harvests, :credits, :integer
  end
end
