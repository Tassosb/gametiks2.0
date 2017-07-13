class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id, index: true
      t.integer :contact_id, index: true
      t.timestamps
    end
  end
end
