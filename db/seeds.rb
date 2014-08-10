assignments_path = Rails.root.join("db/data/assignments")

Dir.entries(assignments_path).each do |filename|
  next if !filename.ends_with?(".md")

  filepath = assignments_path.join(filename)
  attr = Assignment.parse(File.read(filepath))

  assignment = Assignment.find_by(slug: attr[:slug])
  assignment ||= Assignment.new(slug: attr[:slug])
  assignment.update!(attr)
end

challenges_path = Rails.root.join("db/data/challenges")

Dir.entries(challenges_path).each do |entry|
  next if entry.starts_with?(".")

  path = File.join(challenges_path, entry)

  if File.directory?(path)
    Challenge.import!(path)
  end
end
