module UsersHelper

  # Current user level
  def level(user)
    total_kills = 0
    user.harvests.each do
      total_kills += 1
    end

    sum = 0
    counter = 0
    while sum < total_kills do
      counter += 1
      sum += counter
    end

    sprintf '%02d', counter
  end

def first_name(user)
  name = user.name
  if name.index(' ') == nil
    return name
  else
    space_index = name.index(' ') - 1
    return name.slice(0..space_index).capitalize
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

  if weapons.values.all? { |weapon| weapon == 0 }
    return 'null'
  else
    return weapons.max_by{|k, v| v}.first.to_s
  end
end


def favorite_animal(user)
  animals = count_harvests(user)

  if animals.values.all? { |animal| animal == 0 }
    return 'null'
  else
    return animals.max_by{|k, v| v}.first.to_s
  end
end

  def rank(user)
    ordered = User.order(:points)
    userIndex = ordered.reverse.index(user)
    userIndex + 1
  end

  def count_harvests(user)
    animals = {
      turkey: 0,
      deer: 0,
      bear: 0,
      moose: 0,
      bovid: 0,
      canine: 0,
      water_fowl: 0,
      miscellaneous: 0
    }

    user.harvests.each do |harvest|
      current_animal = harvest.animal_type.to_sym
      animals[current_animal] += 1
    end

    animals
  end

end
