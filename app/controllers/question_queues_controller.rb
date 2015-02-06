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

  def update
    @question_queue = QuestionQueue.find(params[:id])
    @question_queue.update_attributes(status: params[:status], user: current_user)
    @question_queue.save!

    redirect_to team_question_queues_path(@question_queue.team)
  end
end
