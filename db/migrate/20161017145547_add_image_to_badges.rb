class AddImageToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :title, :string
    add_column :badges, :image, :string
  end
end
