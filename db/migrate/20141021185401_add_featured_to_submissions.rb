class AddFeaturedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :featured, :boolean, null: false, default: false
  end
end
