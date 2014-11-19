class LikesController < ApplicationController
  def create
    submission = Submission.find(params[:submission_id])
    like = submission.likes.build(user: current_user)
    like.save
    redirect_to :back
  end
end
