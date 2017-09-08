class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order('created_at').limit(7)
  end

  def mark_read
    notification_ids = params[:notifications] || []
    notification_ids.each do |id|
      notification = Notification.find(id.to_i)
      notification.mark_as_read!
    end
  end

  private

  def notification_params
    params.permit(:notifications)
  end

end
