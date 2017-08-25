class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :harvest

  validates :user_id, uniqueness: {scope: :harvest_id}
end
