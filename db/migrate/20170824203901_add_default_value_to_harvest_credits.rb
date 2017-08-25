class AddDefaultValueToHarvestCredits < ActiveRecord::Migration[5.0]
  def change
    change_column_default :harvests, :credits, 0
  end
end
