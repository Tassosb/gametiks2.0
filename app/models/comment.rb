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
    # harvest.comments.each do |comment|
    #   comment.user.each do |commenter|
    #     # don't send notification to comment writer (duh)
    #     # don't send to harvest owner (would be duplicate notification)
    #     unless commenter == harvest.user || commenter == current_user
    #       notification_attrs = {
    #         user_id: commenter.id,
    #         notifiable_type: Comment,
    #         notifiable_id: id
    #       }
    #       notification = Notification.new(notification_attrs)
    #       notification.save!
    #     end
    #   end
    # end
  end

end
