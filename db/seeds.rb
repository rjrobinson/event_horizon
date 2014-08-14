challenges_path = Rails.root.join("db/data/challenges")

Dir.entries(challenges_path).each do |entry|
  next if entry.starts_with?(".")

  path = File.join(challenges_path, entry)

  if File.directory?(path)
    Challenge.import!(path)
  end
end
