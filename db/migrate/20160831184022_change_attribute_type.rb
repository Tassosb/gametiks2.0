class ChangeAttributeType < ActiveRecord::Migration
  def change
    change_column :harvests, :weapon_type, :string
  end
end
