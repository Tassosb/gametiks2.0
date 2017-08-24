class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def update_resource(resource, params)
   if params[:password].strip != ""
     resource.password = params[:password]
     resource.password_confirmation = params[:password_confirmation]
   end
   resource.update_without_password(params)
  end

end
