class QuestionQueuesController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @question_queues = QuestionQueue.for_team(@team)
  end

  def create
    @question = Question.find(params[:question_id])
    @question.queue

    redirect_to questions_path(@question)
  end

  def update
    @question_queue = QuestionQueue.find(params[:id])
    @question_queue.update_in_queue(question_queue_params[:status], current_user)

    redirect_to team_question_queues_path(@question_queue.team)
  end

  private

  def question_queue_params
    params.require(:question_queue).permit(:status)
  end
end
