class Harvest < ActiveRecord::Base
  belongs_to :user

  # CarrierWave gem uploader
  mount_uploader :image, HarvestUploader

  validates :animal_type, :weapon_type, :weight, :image, :latitude, :longitude, presence: true

  def save_points
    self.user.save_points
  end

end
