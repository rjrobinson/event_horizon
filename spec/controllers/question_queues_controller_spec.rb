require 'rails_helper'

describe QuestionQueuesController do
  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }
    let(:question) { FactoryGirl.create(:question, user: user) }

    before do
      FactoryGirl.create(:team_membership, user: user, team: team)
    end

    it 'redirects to the question#show route' do
      post :create, question_id: question.id
      expect(response).to redirect_to(questions_path(question))
    end

    it 'calls the queue method on the question' do
      question = double(id: 1)
      allow(Question).to receive(:find).and_return(question)
      expect(question).to receive(:queue)

      post :create, question_id: question.id
    end
  end
end
