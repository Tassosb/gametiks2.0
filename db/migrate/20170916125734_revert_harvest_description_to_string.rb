class RevertHarvestDescriptionToString < ActiveRecord::Migration[5.0]
  def change
    change_column :harvests, :description, :string
  end
end
