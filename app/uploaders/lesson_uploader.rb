class LessonUploader < CarrierWave::Uploader::Base
  def fog_public
    true
  end

  def store_dir
    "downloads/lessons/#{mounted_as}/#{model.slug}"
  end
end
