class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :mailbox, :conversation
  around_action :set_current_user

  def after_sign_in_path_for(resource)
    @user = current_user
  end

 private

 def set_current_user
   Current.user = current_user
   yield
 ensure
   # to address the thread variable leak issues in Puma/Thin webserver
   Current.user = nil
 end

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
