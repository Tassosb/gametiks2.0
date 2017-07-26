class Harvest < ActiveRecord::Base
  belongs_to :user

  # CarrierWave gem uploader
  mount_uploader :image, HarvestUploader

  validates :animal_type, :weapon_type, :weight, :image, :latitude, :longitude, presence: true
  before_save :review_earned_badges

  def reward_badges_if_won
    new_badges = compare_badges
    if new_badges.length == 0
      return
    else
      new_badges.each do |badge|
        user.award(badge)
      end
      # return for flash
      return new_badges.map(&:title).join(", ")
    end
  end

  def save_points
    user.save_points
  end

  private

  def review_earned_badges
    @earned_badges = []
    user.badges.each do |badge|
      @earned_badges << badge
    end
    delete_duplicates
    @earned_badges
  end

  def delete_duplicates
    #  TODO // Not working
    user.badges = user.badges.distinct!
  end

  def compare_badges
    all_badges = Badge.return_badges(user)
    new_badges = all_badges - @earned_badges
  end

end
