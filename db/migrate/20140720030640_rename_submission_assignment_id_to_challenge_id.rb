class RenameSubmissionAssignmentIdToChallengeId < ActiveRecord::Migration
  def change
    rename_column :submissions, :assignment_id, :challenge_id
  end
end
