class ChangeHarvestDescriptionField < ActiveRecord::Migration[5.0]
  def change
    change_column :harvests, :description, :text
  end
end
