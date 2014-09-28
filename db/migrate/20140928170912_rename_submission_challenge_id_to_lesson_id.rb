class RenameSubmissionChallengeIdToLessonId < ActiveRecord::Migration
  def change
    rename_column :submissions, :challenge_id, :lesson_id
  end
end
