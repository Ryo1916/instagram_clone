class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process resize_to_fit: [300, 300]
  process convert: 'jpg'

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  def default_url
    'default.jpg'
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  # jpgで変換するのではなく、拡張子を変えずにファイル名だけ変えられないか？
  def filename
    "avatar_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg" if original_filename
  end
end
