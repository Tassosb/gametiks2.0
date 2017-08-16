class AddDescriptionToBadges < ActiveRecord::Migration[5.0]
  def change
    add_column :badges, :description, :string
  end
end
