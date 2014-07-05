class Assignment < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  def self.parse(contents)
    headers = YAML.load(contents)
    body = contents.gsub(/---(.|\n)*---/, "")
    { title: headers["title"], body: body }
  end
end
