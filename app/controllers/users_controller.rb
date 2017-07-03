class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    gon.clear
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url
   # Gather harvest coordinates for map
    @coords = []
    @images = []
    @user.harvests.each do |harvest|
      @coords.push [harvest.latitude, harvest.longitude]
      @images.push harvest.image.url(:thumb)
    end
    # coordinates saved using gon gem to talk to javascript
    gon.harvestCoords = @coords
    gon.images = @images
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

  end

  private

    def user_params

    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


end
