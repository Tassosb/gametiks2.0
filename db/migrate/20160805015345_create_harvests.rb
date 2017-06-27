class CreateHarvests < ActiveRecord::Migration
  def change
    create_table :harvests do |t|
      t.belongs_to :user, index: true
      t.integer :animal_type
      t.integer :weapon_type
      t.datetime :date_of_harvest
      t.timestamps
    end
  end
end

