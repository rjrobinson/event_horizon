class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :comments
  has_many :files, class_name: "SourceFile"

  validates :user, presence: true
  validates :assignment, presence: true

  def body=(value)
    files << SourceFile.new(body: value)
  end

  def body
    file = files.first
    file && file.body
  end

  def archive=(uploaded_file)
    Dir.mktmpdir do |tmpdir|
      filename = uploaded_file.original_filename
      archive_path = File.join(tmpdir, filename)
      File.open(archive_path, "wb") do |file|
        file.write(uploaded_file.read)
      end

      extract_source_files(archive_path)
    end
  end

  def inline_comments
    comments.where("line_number IS NOT NULL")
  end

  def extract_source_files(archive_path)
    directory = File.dirname(archive_path)

    # Probably need to escape something here.
    `tar zxf #{archive_path} -C #{directory}`
    `rm #{archive_path}`

    valid_source_files(directory).each do |filepath|
      files << SourceFile.new(body: File.read(filepath),
                              filename: File.basename(filepath))
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
