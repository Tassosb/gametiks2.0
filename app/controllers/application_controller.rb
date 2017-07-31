class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :mailbox, :conversation

 private

 def mailbox
   @mailbox ||= current_user.mailbox
 end

 def conversation
   @conversation ||= mailbox.conversations.find(params[:id])
 end

 def require_login
   redirect_to user_session_url unless current_user
 end

end
