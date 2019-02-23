class ImageUploader < CarrierWave::Uploader::Base
  # avatar_uploaderと同じ内容は使い回せないか？
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process resize_to_fit: [500, 500]
  process convert: 'jpg'

  version :thumb do
    process resize_to_fit: [300, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def filename
    "post_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg" if original_filename
  end
end
