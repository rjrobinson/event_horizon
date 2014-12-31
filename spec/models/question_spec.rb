require "rails_helper"

describe Question do
  describe "validations" do
    it "can only accept answers belonging to this question" do
      question = FactoryGirl.create(:question)
      valid_answer = FactoryGirl.create(:answer, question: question)
      invalid_answer = FactoryGirl.create(:answer)

      question.accepted_answer = valid_answer
      expect(question.valid?).to eq(true)

      question.accepted_answer = invalid_answer
      expect(question.valid?).to eq(false)
    end
  end

  describe "#sorted_answers" do
    it "returns accepted answers before others" do
      question = FactoryGirl.create(:question)
      unaccepted_answer = FactoryGirl.create(:answer, question: question)
      accepted_answer = FactoryGirl.create(:answer, question: question)

      question.accepted_answer = accepted_answer
      question.save!

      expect(question.sorted_answers).to eq([accepted_answer, unaccepted_answer])
    end
  end
end
