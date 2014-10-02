namespace :horizon do
  task import_lessons: :environment do
    dir = Rails.root.join("db/sample_lessons")

    Dir.entries(dir).each do |filename|
      path = File.join(dir, filename)

      if File.directory?(path) && !filename.start_with?(".")
        Lesson.import!(path)
      end
    end
  end
end
