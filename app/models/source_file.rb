class SourceFile < ActiveRecord::Base
  has_many :comments
  belongs_to :submission

  validates :submission, presence: true
  validates :filename, presence: true
  validates :body, presence: true
end
