namespace :horizon do
  task import_lessons: :environment do
    curriculum_repo = ENV["CURRICULUM_GIT_REPO"] || "git@github.com:LaunchAcademy/curriculum"

    Dir.mktmpdir("curriculum") do |tmpdir|
      if system("git", "clone", curriculum_repo, File.join(tmpdir, "curriculum"))
        lessons_dir = File.join(tmpdir, "curriculum", "lessons")

        Dir.entries(lessons_dir).each do |filename|
          path = File.join(lessons_dir, filename)

          if File.directory?(path) && !filename.start_with?(".")
            Lesson.import!(path)
          end
        end
      else
        puts "Failed to clone curriculum repo."
      end
  end
  end
end
