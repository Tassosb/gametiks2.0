class Harvest < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :credits, dependent: :destroy

  # CarrierWave gem uploader
  mount_uploader :image, HarvestUploader

  validates :animal_type, :weapon_type, :weight, :image, :latitude, :longitude, presence: true
  validate :latitude_exists, :longitude_exists
  before_save :review_earned_badges

  def credit(user)
    credits << Credit.new(user: user)
  end

  def reset_counter

  end

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

  def formatted_points
    totalPoints = 0
      case self.animal_type
      when 'bear'
        totalPoints += (weight * 4)
      when 'moose'
        totalPoints += (weight * 0.9).round
      when 'turkey'
        totalPoints += (weight * 10)
      when 'deer'
        totalPoints += (weight * 3.8).round
      when 'bovid'
        totalPoints += (weight * 3.9).round
      when 'canine'
        totalPoints += 250
      when 'water_fowl'
        totalPoints += 250
      else
        totalPoints += 250
      end
    sprintf '%06d', totalPoints
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

  def latitude_exists
    unless (is_number?(latitude) && latitude.to_f.abs <= 90)
      errors.add(:latitude, 'must be between -90 and 90')
    end
  end

  def longitude_exists
    unless (is_number?(longitude) && longitude.to_f.abs <= 180)
      errors.add(:longitude, 'must be between -180 and 180')
    end
  end

  def is_number?(string)
    true if Float(string) rescue false
  end

end
