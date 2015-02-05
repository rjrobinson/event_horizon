class QuestionQueuesController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @question_queues = QuestionQueue.where(team: @team)
  end

  def create
    @question = Question.find(params[:question_id])
    @question.queue

    redirect_to questions_path(@question)
  end
end
