class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :harvest
  has_many :notifications, as: :notifiable

  validates :body, presence: true, allow_blank: false

  after_save :send_notifications

private

  def send_notifications
    # create notification for harvest owner
    notification_attrs = {user_id: harvest.user_id,
                  notifiable_type: Comment,
                  notifiable_id: id,
                }
                notification = Notification.new(notification_attrs)
                notification.save!

    # create notifications for everyone else subscribed to harvest
    user_notifications = {}
    harvest.comments.each do |comment|
      # don't send notification to comment writer (duh)
      # don't send to harvest owner (would be duplicate notification)
      # don't send multiple notifications to the same dude / dudette (one person writes multiple comments)
      unless comment.user_id == harvest.user_id || comment.user_id == Current.user.id
        notification_attrs = {
          user_id: comment.user_id,
          notifiable_type: Comment,
          notifiable_id: id
        }
        notification = Notification.new(notification_attrs)
        user_id = notification_attrs[:user_id]
        user_notifications[user_id] = notification
      end
    end
    
    user_notifications.each { |id, note| note.save! }
  end

end
