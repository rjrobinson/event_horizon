assignments_path = Rails.root.join("db/data/assignments")

Dir.entries(assignments_path).each do |filename|
  next if !filename.ends_with?(".md")

  filepath = assignments_path.join(filename)
  attr = Assignment.parse(File.read(filepath))

  Assignment.find_or_create_by(title: attr[:title]) do |a|
    a.body = attr[:body]
  end
end
