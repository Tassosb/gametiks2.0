class RemoveNullConstraint < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:credits, :created_at, true )
    change_column_null(:credits, :updated_at, true )
  end
end
