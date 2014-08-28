class Challenge < ActiveRecord::Base
  has_many :submissions

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true
  validates :archive, presence: true

  mount_uploader :archive, ChallengeUploader

  def to_param
    slug
  end

  def submissions_viewable_by(user)
    if user.admin?
      submissions
    else
      if has_submission_from?(user)
        submissions.where("user_id = ? OR public = true", user.id)
      else
        submissions.none
      end
    end
  end

  def has_submission_from?(user)
    submissions.exists?(user: user)
  end

  def self.import!(dir)
    slug = File.basename(dir)
    info = YAML.load(File.read(File.join(dir, ".challenge")))
    body = File.read(File.join(dir, "README.md"))

    challenge = Challenge.find_by(slug: slug)
    challenge ||= Challenge.new(slug: slug)

    challenge.title = info["title"]
    challenge.description = info["description"]
    challenge.body = body

    Dir.mktmpdir("challenge") do |tmpdir|
      challenges_dir = File.dirname(dir)
      archive_path = File.join(tmpdir, "#{slug}.tar.gz")
      system("tar zcf #{archive_path} -C #{challenges_dir} #{slug}")
      challenge.archive = File.open(archive_path)
      challenge.save!
    end

    challenge
  end

  def self.import_all!
    Dir.mktmpdir do |tmpdir|
      `git clone https://github.com/atsheehan/challenges.git #{tmpdir}`

      challenge_pattern = File.join(tmpdir, "**/.challenge")
      Dir[challenge_pattern].each do |challenge_file|
        Challenge.import!(File.dirname(challenge_file))
      end
    end
  end
end
