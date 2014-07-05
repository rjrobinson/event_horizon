class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  has_many :submissions

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], body: body }
  end
end
