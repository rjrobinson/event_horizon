namespace :horizon do
  task import_lessons: :environment do
    dir = Rails.root.join("db/sample_lessons")

    Dir.entries(dir).each do |filename|
      if filename.ends_with?(".md")
        path = File.join(dir, filename)
        Lesson.import!(path)
      end
    end
  end
end
