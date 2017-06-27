class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :harvests, :animal_type, :string
  end
end
