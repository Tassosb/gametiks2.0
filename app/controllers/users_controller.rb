class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    gon.clear
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @harvests = @user.harvests.order(sort_column + " " + sort_direction)
    gon.clear
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
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:latitude, :longitude, :avatar)
    if @user.update_attributes(user_params) && params[:user].include?('avatar')
      redirect_to current_user
    else
      render @user.errors.full_messages
    end
  end

  private

  def sort_column
    Harvest.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
