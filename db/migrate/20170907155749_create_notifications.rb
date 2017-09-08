class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, index: true
      t.references :user, index: true
      t.boolean :is_read?, default: false
      t.string :activity_type
      t.timestamps
    end
  end
end
