class AddCommentCounterCacheToSubmissions < ActiveRecord::Migration
  class Comment < ActiveRecord::Base
    belongs_to :submission, counter_cache: true
  end

  class Submission < ActiveRecord::Base
    has_many :comments
  end

  def up
    add_column :submissions, :comments_count, :integer, null: false, default: 0

    Submission.pluck(:id).each do |id|
      Submission.reset_counters(id, :comments)
    end
  end

  def down
    remove_column :submissions, :comments_count
  end
end
