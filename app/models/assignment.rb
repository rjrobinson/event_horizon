class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :submissions

  def to_param
    slug
  end

  def self.search(query)
    where("to_tsvector(title || ' ' || body) @@ plainto_tsquery(?)", query)
  end

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], slug: headers["slug"], body: body }
  end
end
