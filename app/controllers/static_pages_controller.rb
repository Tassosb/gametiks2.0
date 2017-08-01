class StaticPagesController < ApplicationController
  def home
    allHarvests = Harvest.includes(:user).all
    gon.allHarvests = allHarvests.to_json(include: [ :user ])
    @sampled_users = User.order("RANDOM()").limit(5)
  end

  def help
  end

  def about
  end

  def contact
  end
end
