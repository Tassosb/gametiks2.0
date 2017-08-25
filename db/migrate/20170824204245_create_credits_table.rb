class CreateCreditsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.belongs_to :harvest
      t.belongs_to :user
    end
  end
end
