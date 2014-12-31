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
end
