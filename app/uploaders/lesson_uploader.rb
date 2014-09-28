class LessonUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def fog_public
    true
  end

  def store_dir
    "downloads/lessons/#{mounted_as}/#{model.slug}"
  end
end
