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

  describe '#update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }
    let(:question) { FactoryGirl.create(:question, user: user) }
    let(:question_queue) { FactoryGirl.create(:question_queue, question: question, team: team) }
    let(:experience_engineer) { FactoryGirl.create(:admin) }

    before do
      FactoryGirl.create(:team_membership, user: user, team: team)
      session[:user_id] = experience_engineer.id
    end

    it 'redirects to the queue index' do
      patch :update, id: question_queue.id, question_queue: { status: 'in progress' }
      expect(response).to redirect_to(team_question_queues_path(team))
    end

    context "i'm on it" do
      it 'updates the question_queue with the current status' do
        patch :update, id: question_queue.id, question_queue: { status: 'in progress' }
        expect(question_queue.reload.status).to eq 'in progress'
      end

      it 'sets the user id of the answering ee' do
        patch :update, id: question_queue.id, question_queue: { status: 'in progress' }
        expect(question_queue.reload.user).to eq experience_engineer
      end
    end
  end
end
