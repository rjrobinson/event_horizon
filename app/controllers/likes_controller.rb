class LikesController < ApplicationController
  def create
    submission = Submission.find(params[:submission_id])
    like = submission.likes.build(user: current_user)
    if !like.save
      flash[:error] = like.errors.full_messages.join
    end
    redirect_to :back
  end
end
