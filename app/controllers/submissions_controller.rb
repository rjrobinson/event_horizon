class SubmissionsController < ApplicationController
  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @submission = Submission.new
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.build(submission_params)
    @submission.user = current_user

    if @submission.save
      flash[:info] = "Solution submitted."
      redirect_to submission_path(@submission)
    else
      render :new
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:body)
  end
end
