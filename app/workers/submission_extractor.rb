class SubmissionExtractor
  include Sidekiq::Worker

  def perform(submission_id)
    submission = Submission.find(submission_id)

    submission.archive.cache_stored_file!

    Dir.mktmpdir do |tmpdir|
      archive_path = File.join(tmpdir, "archive.tar.gz")
      system("cp #{submission.archive.path} #{archive_path}")
      system("tar zxf #{archive_path} -C #{tmpdir}")
      system("rm #{archive_path}")

      SourceFile.transaction do
        valid_source_files(tmpdir).each do |filepath|
          SourceFile.create!(body: File.read(filepath),
                             submission: submission,
                             filename: File.basename(filepath))
        end
      end
    end
  end

  private

  def valid_source_files(dir)
    filenames = Dir.entries(dir).reject do |filename|
      filename == "." || filename == ".."
    end

    filepaths = filenames.map { |filename| File.join(dir, filename) }
    filepaths.select { |filepath| !File.directory?(filepath) }
  end
end
