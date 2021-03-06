# encoding: utf-8

class HarvestUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  watermark = MiniMagick::Image.open('https://s3.amazonaws.com/gametiks/images/gametiks_watermark.png')
  # Process files as they are uploaded:
  version :square do
    process :auto_orient
    process :quality => 55
    process resize_to_fill: [800, 800]
    process watermark: watermark
  end

  version :thumb do
    process :auto_orient
    process :quality => 85
    process :resize_to_fill => [220, 220]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
