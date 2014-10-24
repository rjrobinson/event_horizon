namespace :horizon do
  task import_lessons: :environment do
    repo = ENV["CURRICULUM_GIT_REPO"] ||
      "https://github.com/LaunchAcademy/curriculum"

    Dir.mktmpdir("curriculum") do |tmpdir|
      if system("git", "clone", repo, File.join(tmpdir, "curriculum"))
        Lesson.import_all!(File.join(tmpdir, "curriculum", "lessons"))
      else
        puts "Failed to clone curriculum repo."
      end
    end
  end
end
