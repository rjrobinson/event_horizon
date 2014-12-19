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
          filepath = File.join(tmpdir, filename)

          file = submission.files.find_or_initialize_by(filename: filename)
          file_size = File.stat(filepath).size

          if file_size < 50000
            file.body = File.read(filepath)
          else
            file.body = "File too large to display (#{file_size} bytes)"
          end

          begin
            file.save!
          rescue
            Sidekiq.logger.debug "Error saving #{filename} to database."
          end
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
        if prefix
          find_files(File.join(prefix, filename), path)
        else
          find_files(filename, path)
        end
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
