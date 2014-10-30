class AddCommentCounterCacheToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :comments_count, :integer
  end
end
