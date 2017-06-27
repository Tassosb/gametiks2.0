class AddColumnToHarvest < ActiveRecord::Migration
  def change
    add_column :harvests, :description, :string
  end
end
