class Badge < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.return_badges(user)
    harvests = []
    user.harvests.each do |harvest|
      harvests << harvest
    end

    all_badges = []
    all_badges << Badge.find_by_title('Deer Hunter') if harvests.any? { |harvest| harvest.animal_type == 'deer' }
    all_badges << Badge.find_by_title('Bear Hunter') if harvests.any? { |harvest| harvest.animal_type == 'bear' }
    all_badges << Badge.find_by_title('Turkey Hunter') if harvests.any? { |harvest| harvest.animal_type == 'turkey' }
    all_badges << Badge.find_by_title('Moose Hunter') if harvests.any? { |harvest| harvest.animal_type == 'moose' }
    all_badges << Badge.find_by_title('Duck Hunter') if harvests.any? { |harvest| harvest.animal_type == 'water_fowl' }
    all_badges << Badge.find_by_title('Canine Hunter') if harvests.any? { |harvest| harvest.animal_type == 'canine' }
    all_badges << Badge.find_by_title('Archer') if harvests.count { |harvest| harvest.weapon_type == 'bow' } >= 3
    all_badges << Badge.find_by_title('Gunslinger') if harvests.count { |harvest| harvest.weapon_type == 'pistol' } >= 3
    all_badges << Badge.find_by_title('Shotgunner') if harvests.count { |harvest| harvest.weapon_type == 'shotgun' } >= 3
    all_badges << Badge.find_by_title('Rifleman') if harvests.count { |harvest| harvest.weapon_type == 'rifle' } >= 3

    all_badges
  end

end
