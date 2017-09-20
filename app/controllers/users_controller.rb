class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_login, except: :index

  def index
    gon.clear
    respond_to do |format|
      format.html { @users = User.all.order('points DESC').page(params[:page]).per(50) }
      if params['search']
        search_string = params['search']
        if search_string.length >= 1
          format.js {@users =  User.where("lower(name) LIKE ?", "#{search_string.downcase}%").limit(10)}
        else
          format.js {@users = []}
        end
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @harvests = @user.harvests.order('COALESCE(date, created_at) DESC')
    gon.clear
    userHarvests = @user.harvests.includes(:user)
    gon.harvests = userHarvests.to_json(include: [ :user ])
    allHarvests = Harvest.includes(:user).all
    gon.allHarvests = allHarvests.to_json(include: [ :user ])
    gon.userId = @user.id
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
    # Harvest.column_names.include?(params[:sort]) ? "COALESCE(#{params[:sort]}, created_at)" : "COALESCE(date, created_at)"
  end

  def sort_direction
    # %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
