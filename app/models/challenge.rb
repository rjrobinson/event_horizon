class Challenge < ActiveRecord::Base
  has_many :submissions

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true

  def to_param
    slug
  end

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], slug: headers["slug"], body: body }
  end
end
