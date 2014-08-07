class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission
  belongs_to :source_file

  validates :user, presence: true
  validates :submission, presence: true
  validates :body, presence: true
  validates :line_number,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :source_file, presence: true, if: -> { line_number.present? }
  validates :line_number, presence: true, if: -> { source_file.present? }
end
