class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :comments
  has_many :files, class_name: "SourceFile"

  validates :user, presence: true
  validates :assignment, presence: true
  validates :body, presence: true

  def body=(value)
    files << SourceFile.new(body: value)
  end

  def body
    file = files.first
    file && file.body
  end

  def inline_comments
    comments.where("line_number IS NOT NULL")
  end
end
