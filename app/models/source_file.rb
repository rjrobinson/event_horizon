class SourceFile < ActiveRecord::Base
  has_many :comments
  belongs_to :submission

  validates :submission, presence: true
  validates :filename, presence: true
  validates :body, length: { in: 0..50000, allow_nil: false }
end
