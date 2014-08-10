class ChallengeUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "downloads/challenges/#{mounted_as}/#{model.slug}"
  end
end
