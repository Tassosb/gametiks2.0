module HarvestsHelper

  def formatted_weight(lbs)
    "#{lbs} lbs / #{(lbs * 0.453592).round} kgs"
  end

end
