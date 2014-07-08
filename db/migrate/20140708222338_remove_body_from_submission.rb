class RemoveBodyFromSubmission < ActiveRecord::Migration
  class Submission < ActiveRecord::Base; end
  class SourceFile < ActiveRecord::Base; end

  def up
    ActiveRecord::Base.transaction do
      Submission.all.each do |submission|
        SourceFile.create!(submission_id: submission.id, body: submission.body)
      end
    end

    remove_column :submissions, :body
  end

  def down
    add_column :submissions, :body, :text

    ActiveRecord::Base.transaction do
      Submission.all.each do |submission|
        file = SourceFile.find_by(submission_id: submission.id)

        if !file.nil?
          submission.body = file.body
        else
          submission.body = ""
        end

        submission.save
      end
    end

    SourceFile.delete_all
    change_column :submissions, :body, :text, null: false
  end
end
