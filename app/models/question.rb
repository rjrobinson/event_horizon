class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :accepted_answer,
    class_name: "Answer"
  has_many :answers,
    dependent: :destroy
  has_many :question_queue

  validates :title, presence: true, length: { in: 10..200 }
  validates :body, presence: true, length: { in: 15..10000 }
  validates :user, presence: true

  validate :accepted_answer_belongs_to_question

  scope :queued, ->() {
    joins(:question_queue).
    where("question_queues.question_id IS NOT NULL AND question_queues.status NOT LIKE '%done%'")
  }

  def accepted_answer_belongs_to_question
    if accepted_answer && !answers.include?(accepted_answer)
      errors.add(:accepted_answer_id, "must belong to this question")
    end
  end

  def sorted_answers
    answers.sort_by { |answer| answer.accepted? ? 0 : 1 }
  end

  def self.unanswered
    where(answers_count: 0)
  end

  def queue
    user.teams.each do |team|
      QuestionQueue.create(question: self, team: team)
    end
  end

  def self.search(query)
    where("searchable @@ plainto_tsquery(?)", query)
  end
end
