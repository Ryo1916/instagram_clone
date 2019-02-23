class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process resize_to_fit: [300, 300]

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

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
end
