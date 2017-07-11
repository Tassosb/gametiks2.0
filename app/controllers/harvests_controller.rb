class HarvestsController < ApplicationController

  def new
    @user = current_user
    @harvest = Harvest.new
    gon.userLat = @user.latitude;
    gon.userLng = @user.longitude;
  end

  def edit
    @harvest = Harvest.find(params[:id])
  end

  def create
    @harvest = Harvest.new(harvest_params)
    @harvest.user_id = current_user.id
    if @harvest.save
      @harvest.user.save_points
      flash[:success] = "Harvest successfully created"
      redirect_to current_user
    else
      flash[:errors] = @harvest.errors.full_messages
      render :new
    end
  end

  def update
    @harvest = Harvest.find(params[:id])
    if @harvest.update_attributes(harvest_params)
      redirect_to current_user
    else
      render @harvest.errors.full_messages
    end
  end

  def destroy
    @harvest = Harvest.find(params[:id])
    @harvest.destroy!
    redirect_to current_user, notice: 'Harvest was successfully destroyed.'
  end

  private

  def harvest_params
    params.require(:harvest).permit(:weapon_type, :animal_type, :weight, :description, :image, :latitude, :longitude)
  end

end
