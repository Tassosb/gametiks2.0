class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def mark_as_read!
    self[:is_read?] = true
    self.save
  end
end
