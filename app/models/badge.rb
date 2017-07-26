class Badge < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.return_badges(user)
    harvests = []
    user.harvests.each do |harvest|
      harvests << harvest.animal_type
    end

    all_badges = []
    all_badges << Badge.find_by_title('Deer Hunter') if harvests.include?('deer')
    all_badges << Badge.find_by_title('Bear Hunter') if harvests.include?('bear')
    all_badges << Badge.find_by_title('Turkey Hunter') if harvests.include?('turkey')
    all_badges << Badge.find_by_title('Moose Hunter') if harvests.include?('moose')
    all_badges
  end

end
