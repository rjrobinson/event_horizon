class AddCommentCounterCacheToSubmissions < ActiveRecord::Migration
  def up
    add_column :submissions, :comments_count, :integer, null: false, default: 0

    Submission.all.pluck(:id) do |id|
      Submission.reset_counters(id, :comments)
    end
  end

  def down
    remove_column :submissions, :comments_count
  end
end
