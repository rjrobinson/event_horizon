class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :submissions

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], slug: headers["slug"], body: body }
  end
end
