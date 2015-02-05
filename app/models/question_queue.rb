class QuestionQueue < ActiveRecord::Base
  belongs_to :question
  belongs_to :team
end
