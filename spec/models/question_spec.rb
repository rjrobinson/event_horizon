require "rails_helper"

describe Question do
  describe 'scopes' do
    describe 'queued' do
      it 'returns questions that are in the question_queue and not done' do
        question1 = FactoryGirl.create(:question)
        question2 = FactoryGirl.create(:question)
        question3 = FactoryGirl.create(:question)
        FactoryGirl.create(:question_queue, question: question1, status: 'done')
        FactoryGirl.create(:question_queue, question: question2, status: 'open')
        FactoryGirl.create(:question_queue, question: question3, status: 'in-progress')

        expect(Question.queued).to match_array([question2, question3])
      end
    end
  end

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

  describe "#queue" do
    let(:question) { FactoryGirl.create(:question, user: user) }
    let(:team) { FactoryGirl.create(:team) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:team_membership, team: team, user: user)
    end

    context '#question queued for a user in one team' do
      it 'creates a single question_queue' do
        expect{
          question.queue
        }.to change{QuestionQueue.count}.by(1)
      end
    end

    context '#question queued for a user in more than one team' do
      it 'creates a question_queue for each team' do
        team2 = FactoryGirl.create(:team)
        FactoryGirl.create(:team_membership, team: team2, user: user)

        expect{
          question.queue
        }.to change{QuestionQueue.count}.by(2)
      end
    end
  end
end
