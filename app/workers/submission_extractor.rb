class SubmissionExtractor
  include Sidekiq::Worker

  def perform(submission_id)
  end
end
