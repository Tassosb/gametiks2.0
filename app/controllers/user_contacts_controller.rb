class UserContactsController < ApplicationController

  def create
    @user_contact = UserContact.new(user_contact_params)
    @user_contact.user_id = current_user.id
    @contacted_user = User.find(@user_contact.contact_id)
    if @user_contact.save
      redirect_to user_path(@contacted_user)
    else
      render @user_contact.errors.full_messages
    end
  end

  def destroy

  end

  private

  def user_contact_params
    params.require(:user_contact).permit(:contact_id)
  end

end
