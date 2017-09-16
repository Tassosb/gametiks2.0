class HarvestsController < ApplicationController

  def new
    gon.clear
    @user = current_user
    @harvest = Harvest.new
    gon.user_id = @user.id
    gon.userLat = @user.latitude
    gon.userLng = @user.longitude
    gon.action = 'new'
  end

  def edit
    gon.clear
    @user = current_user
    @harvest = Harvest.find(params[:id])
    gon.user_id = @user.id
    gon.userLat = @user.latitude
    gon.userLng = @user.longitude
    gon.harvest = @harvest
    gon.action = 'edit'
  end

  def create
    @date = Date.strptime(harvest_params[:date], '%m/%d/%Y')
    @harvest = Harvest.new(harvest_params)
    @harvest.user_id = current_user.id
    if @harvest.save
      # must manually set date because date hits controller as String
      @harvest.update_column :date, @date
      @harvest.user.save_points
      flash[:success] = "Harvest successfully created"
      # runs entire badge comparisons before rewarding badges
      # has side effect of returning names of newly-won badges
      badge_titles = @harvest.reward_badges_if_won
      flash[:notice] = "You earned these badges: " + badge_titles unless badge_titles == nil
      redirect_to current_user
    else
      flash[:errors] = @harvest.errors.full_messages
      render 'new'
    end
  end

  def update
    @date = Date.strptime(harvest_params[:date], '%m/%d/%Y')
    @harvest = Harvest.find(params[:id])
    if @harvest.update_attributes(harvest_params)
      # manually update date because date field is nil
      @harvest.update_column :date, @date
      @harvest.user.save_points
      flash[:success] = "Harvest successfully updated"
      badge_titles = @harvest.reward_badges_if_won
      flash[:notice] = "You earned these badges: " + badge_titles unless badge_titles == nil
      redirect_to current_user
    else
      render @harvest.errors.full_messages
    end
  end

  def index
    @harvests = Harvest.all.order("credits_count DESC, id DESC").includes(:user).page(params[:page]).per(30)
    gon.total_pages = @harvests.total_pages
  end

  def show
  end

  def destroy
    @harvest = Harvest.find(params[:id])
    @harvest.destroy!
    redirect_to current_user, notice: 'Harvest was successfully destroyed.'
  end

  private



  def harvest_params
    params.require(:harvest).permit(:page, :weapon_type, :animal_type, :weight, :description, :image, :date, :latitude, :longitude)
  end

end
