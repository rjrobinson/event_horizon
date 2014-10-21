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
        valid_source_files(tmpdir).each do |filename|
          file = submission.files.find_or_initialize_by(filename: filename)
          file.body = File.read(File.join(tmpdir, filename))
          file.save!
        end
      end
    end
  end

  private

  def valid_source_files(dir)
    find_files(nil, dir)
  end

  def find_files(prefix, dir)
    filenames(dir).flat_map do |filename|
      path = File.join(dir, filename)

      if File.directory?(path)
        find_files(filename, path)
      else
        if prefix
          File.join(prefix, filename)
        else
          filename
        end
      end
    end
  end

  def filenames(dir)
    Dir.entries(dir).reject do |filename|
      filename == "." || filename == ".." || ignore?(filename)
    end
  end

  def ignore?(filename)
    ignored_files.any? { |pattern| pattern.match(filename) }
  end

  def ignored_files
    [".git", ".DS_Store", /\._.*/, /.*~/]
  end
end
