class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order('created_at DESC').limit(7)
  end

  def mark_read
    notification_ids = params[:notifications] || []
    notification_ids.each do |id|
      next if id == 'empty'
      notification = Notification.find(id.to_i)
      notification.mark_as_read!
    end
  end

  private

  def notification_params
    params.permit(:notifications)
  end

end
