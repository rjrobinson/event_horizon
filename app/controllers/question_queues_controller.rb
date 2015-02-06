class QuestionQueuesController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @question_queues = QuestionQueue.where(team: @team).where.not(status: 'done')
  end

  def create
    @question = Question.find(params[:question_id])
    @question.queue

    redirect_to questions_path(@question)
  end

  def update
    @question_queue = QuestionQueue.find(params[:id])
    @question_queue.update_attributes(status: question_queue_params[:status], user: current_user)
    @question_queue.save!

    redirect_to team_question_queues_path(@question_queue.team)
  end

  private

  def question_queue_params
    params.require(:question_queue).permit(:status)
  end
end
