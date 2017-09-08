class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :harvest, counter_cache: true
  has_many :notifications, as: :notifiable
  validates :user_id, uniqueness: {scope: :harvest_id}

  after_save :send_notifications

  private

  def send_notifications
    # create notification for harvest owner
    notification_attrs = {user_id: harvest.user_id,
                  notifiable_type: Credit,
                  notifiable_id: id,
                }
                notification = Notification.new(notification_attrs)
                notification.save!
  end
end
