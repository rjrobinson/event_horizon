class Lesson < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  has_many :submissions

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true
  validates :type, presence: true, inclusion: ["article", "tutorial", "challenge"]
  validates :position, presence: true, numericality: {
    greater_than_or_equal_to: 1
  }

  mount_uploader :archive, LessonUploader

  def to_param
    slug
  end

  def submissions_viewable_by(user)
    if user.admin?
      submissions
    else
      if submissions.has_submission_from?(user)
        submissions.where("user_id = ? OR public = true", user.id)
      else
        submissions.none
      end
    end
  end

  def self.search(query)
    where("searchable @@ plainto_tsquery(?)", query)
  end

  def self.type(type)
    where(type: type)
  end

  def self.import!(source_dir)
    slug = File.basename(source_dir)

    attributes = YAML.load_file(File.join(source_dir, ".lesson.yml"))
    content = File.read(File.join(source_dir, "#{slug}.md"))

    lesson = Lesson.find_or_initialize_by(slug: slug)
    lesson.body = content
    lesson.title = attributes["title"]
    lesson.description = attributes["description"]
    lesson.type = attributes["type"]
    lesson.position = attributes["position"]

    lesson.save!
  end
end
