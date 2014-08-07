class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  has_many :comments
  has_many :files, -> { order :filename },
           class_name: "SourceFile"

  mount_uploader :archive, ArchiveUploader

  validates :user, presence: true
  validates :challenge, presence: true
  validates :archive, presence: true

  before_validation :save_body

  attr_accessor :body

  def inline_comments
    comments.where("line_number IS NOT NULL AND source_file_id IS NOT NULL")
  end

  def general_comments
    comments.where("line_number IS NULL OR source_file_id IS NULL")
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

  def save_body
    if body.present?
      Dir.mktmpdir do |tmpdir|
        tmp_file_path = File.join(tmpdir, "file001")
        File.write(tmp_file_path, body)

        archive_path = File.join(tmpdir, "submission.tar.gz")
        system("tar zcf #{archive_path} -C #{tmpdir} file001")

        self.archive = File.open(archive_path)
      end
    end
  end

  def valid_source_files(dir)
    filenames = Dir.entries(dir).reject do |filename|
      filename == "." || filename == ".."
    end

    filepaths = filenames.map { |filename| File.join(dir, filename) }
    filepaths.select { |filepath| !File.directory?(filepath) }
  end
end
