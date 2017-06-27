class Harvest < ActiveRecord::Base
  belongs_to :user
  
   # This method associates the attribute ":image" with a file attachment
  has_attached_file :image, styles: {
    thumb: '180x180#'
  }

  # validates :animal_type, :presence => { :if => 'animal_type.nil?' }
  
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  
  # CarrierWave gem uploader
  # mount_uploader :image, ImageUploader
  
  # validates :animal_type, presence: true
  # validates :weapon_type, presence: true
  # validates :image, presence: true
  
   
  
end