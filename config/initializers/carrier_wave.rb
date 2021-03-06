require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_REGION']
  }
  config.fog_directory  = 'gametiks'
  config.fog_attributes = { :cache_control => 'max-age=1200000' }
end

module CarrierWave
  module MiniMagick

    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    def auto_orient
      manipulate! do |img|
        img = img.auto_orient
      end
    end

    def watermark(watermark)
      manipulate! do |img|
        result = img.composite(watermark) do |c|
          c.compose "Over"
          c.geometry "+580+700"
        end
        result
      end
      img = yield(result) if block_given?
    end

  end
end
