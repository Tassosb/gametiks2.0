class AddTimestampsToCredits < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :credits
  end
end
