class Harvest < ActiveRecord::Base
  belongs_to :user

   # This method associates the attribute ":image" with a file attachment
  # has_attached_file :image, styles: {
  #   thumb: '180x180#'
  # }

  # Validate the attached image is image/jpg, image/png, etc
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # CarrierWave gem uploader
  mount_uploader :image, HarvestUploader

  validates :animal_type, :weapon_type, :weight, :image, :latitude, :longitude, presence: true
  # validates :weapon_type, presence: true
  # validates :image, presence: true

  def save_points
    self.user.save_points
  end

end
