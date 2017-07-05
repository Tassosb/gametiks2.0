class HarvestsController < ApplicationController

  def index
    @harvests = Harvest.all
  end

  def show
  end

  def new
    @harvest = Harvest.new
    @user = current_user
    gon.userLat = @user.latitude;
    gon.userLng = @user.longitude;
  end

  def edit
  end

  def create
    @harvest = Harvest.new(harvest_params)
    @harvest.user_id = current_user.id
    if @harvest.save
      flash[:success] = "Harvest successfully created"
      redirect_to current_user
    else
      render @harvest.errors.full_messages
    end
  end

  def update
    respond_to do |format|
      if @harvest.update(harvest_params)
        redirect_to current_user
      else
        render @harvest.errors.full_messages
      end
    end
  end

  def destroy
    @harvest.destroy
    respond_to do |format|
      redirect_to user_url, notice: 'Harvest was successfully destroyed.'
    end
  end

  private

  def harvest_params
    params.require(:harvest).permit(:weapon_type, :animal_type, :weight, :description, :image, :latitude, :longitude)
  end
  
end
