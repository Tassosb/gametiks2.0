class CreditsController < ApplicationController
  respond_to :js

  def credit
    @user = current_user
    @harvest = Harvest.find(params[:harvest_id])
    @harvest.credit(@user)
  end

end
