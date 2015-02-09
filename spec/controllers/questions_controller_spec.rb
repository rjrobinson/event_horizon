require "rails_helper"

describe QuestionsController do
  let(:user) { FactoryGirl.create(:user) }

  describe "PUT update" do
    it "allows original asker to accept an answer" do
      session[:user_id] = user.id

      question = FactoryGirl.create(:question, user: user)
      answer = FactoryGirl.create(:answer, question: question)

      put :update, id: question.id, question: {
        accepted_answer_id: answer.id
      }

      question.reload
      expect(question.accepted_answer).to eq(answer)
    end

    it "prevents other users from accepting answers" do
      session[:user_id] = user.id

      question = FactoryGirl.create(:question)
      answer = FactoryGirl.create(:answer, question: question)

      expect {
        put :update, id: question.id, question: {
          accepted_answer_id: answer.id
        }
      }.to raise_error(ActiveRecord::RecordNotFound)

      question.reload
      expect(question.accepted_answer).to_not eq(answer)
    end
  end
end
