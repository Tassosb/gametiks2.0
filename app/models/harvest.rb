class Harvest < ActiveRecord::Base
  belongs_to :user

  # CarrierWave gem uploader
  mount_uploader :image, HarvestUploader

  validates :animal_type, :weapon_type, :weight, :image, :latitude, :longitude, presence: true
  before_save :review_earned_badges

  def reward_badges_if_won
    new_badges = compare_badges
    if new_badges.length == 0
      return 'None'
    else
      new_badges.each do |badge|
        self.user.badges << badge
      end
      return new_badges.map(&:title).join(", ")
    end
  end

  def save_points
    self.user.save_points
  end

  private

  def review_earned_badges
    @earned_badges = []
    self.user.badges.each do |badge|
      @earned_badges << badge
    end
    delete_duplicates
    @earned_badges
  end

  def delete_duplicates
    #  TODO // Not working
    self.user.badges = self.user.badges.distinct!
  end

  def compare_badges
    all_badges = Badge.return_badges(self.user)
    new_badges = all_badges - @earned_badges
  end

end
