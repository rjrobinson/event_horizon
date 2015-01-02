class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :accepted_answer,
    class_name: "Answer"
  has_many :answers,
    dependent: :destroy

  validates :title, presence: true, length: { in: 10..200 }
  validates :body, presence: true, length: { in: 15..10000 }
  validates :user, presence: true

  validate :accepted_answer_belongs_to_question

  def accepted_answer_belongs_to_question
    if accepted_answer && !answers.include?(accepted_answer)
      errors.add(:accepted_answer_id, "must belong to this question")
    end
  end

  def sorted_answers
    answers.sort_by { |answer| answer.accepted? ? 0 : 1 }
  end

  def self.unanswered_questions
    questions = []
    all.each do |q|
      if q.answers.count == 0
        questions << q
      end
    end
    questions
  end
end
