class AddCommentsToLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :harvest
      t.belongs_to :user
      t.text :body
    end
  end
end
