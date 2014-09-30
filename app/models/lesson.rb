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

  def self.import!(source_file)
    content = File.read(source_file)
    headers = YAML.load(content)

    slug = File.basename(source_file).chomp(".md")

    lesson = Lesson.find_or_initialize_by(slug: slug)
    lesson.body = content.gsub(/---(.|\n)*---/, "")
    lesson.title = headers["title"]
    lesson.description = headers["description"]
    lesson.type = headers["type"]
    lesson.position = headers["position"]
    lesson.save!
  end
end
