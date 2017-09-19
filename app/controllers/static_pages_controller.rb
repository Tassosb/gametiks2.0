class StaticPagesController < ApplicationController
  def home
    allHarvests = Harvest.includes(:user).all
    gon.allHarvests = allHarvests.to_json(include: [ :user ])
    gon.harvestCount = Harvest.all.length
    @sampled_users = User.order("RANDOM()").limit(3)
  end

  def help
  end

  def about
  end

  def contact
  end
end
