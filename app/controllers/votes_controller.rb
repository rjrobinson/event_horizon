class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @submission = Submission.find(params[:submission_id])
    @vote = @submission.votes.build(vote_params)
    @vote.user = current_user
    @vote.save

    flash[:info] = "You have marked this submission as helpful."
    redirect_to @submission
  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
