module UsersHelper

  # Current user level
  def level(user)
    totalKills = 0
    user.harvests.each do
      totalKills += 1
    end
    
    result = 0
    result = totalKills if totalKills <= 2
    result = (totalKills/2.0) if totalKills >= 3 && totalKills <= 8
    result = Math::log(totalKills, 1.6) if totalKills >= 9
    sprintf '%02d', result.ceil
  end

end

def favorite_weapon(user)
  weapons = {
    rifle: 0,
    shotgun: 0,
    pistol: 0,
    bow: 0
  }

  user.harvests.each do |harvest|
    current_weapon = harvest.weapon_type.to_sym
    weapons[current_weapon] += 1
  end

  weapons.max_by{|k, v| v}.first.to_s
end

def favorite_animal(user)
  animals = {
    turkey: 0,
    deer: 0,
    bear: 0,
    moose: 0,
    misc: 0
  }

  user.harvests.each do |harvest|
    current_animal = harvest.animal_type.to_sym
    animals[current_animal] += 1
  end

  animals.max_by{|k, v| v}.first.to_s
end
