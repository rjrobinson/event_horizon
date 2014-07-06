class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :submissions

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], body: body }
  end

  def submissions_viewable_by(user)
    if user.is_instructor?
      submissions
    else
      submissions.where(user: user)
    end
  end
end
