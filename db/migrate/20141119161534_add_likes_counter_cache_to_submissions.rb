class AddLikesCounterCacheToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :likes_count, :integer, null: false, default: 0
  end
end
