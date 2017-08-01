class StaticPagesController < ApplicationController
  def home
    allHarvests = Harvest.includes(:user).all
    gon.allHarvests = allHarvests.to_json(include: [ :user ])
  end

  def help
  end

  def about
  end

  def contact
  end
end
