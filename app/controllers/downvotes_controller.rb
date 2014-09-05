class DownvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @submission = Submission.find(params[:submission_id])
    @downvote = @submission.downvotes.build(downvote_params)
    @downvote.user = current_user
    @downvote.save

    flash[:info] = "Thanks for voting!"
    redirect_to @submission
  end

  private

  def downvote_params
    params.require(:downvote).permit(:value)
  end

end
