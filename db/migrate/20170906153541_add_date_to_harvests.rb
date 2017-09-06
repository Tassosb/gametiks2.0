class AddDateToHarvests < ActiveRecord::Migration[5.0]
  def change
    add_column :harvests, :date, :date
  end
end
