class UsersController < ApplicationController
  # before_action :authenticate_user!, except: [:update]

  def index
    gon.clear
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    gon.harvests = @user.harvests
    gon.allHarvests = Harvest.all
    gon.userId = @user.id
  end

  def new
    # @user = User.new
  end

  def create

  end

  def destroy

  end

  def edit

  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:latitude, :longitude, :avatar)
    if @user.update_attributes(user_params) && params[:user].include?('avatar')
      redirect_to current_user
    end
  end

  private

    # def user_params
    #   params.require(:user).permit(:latitude, :longitude)
    # end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end
