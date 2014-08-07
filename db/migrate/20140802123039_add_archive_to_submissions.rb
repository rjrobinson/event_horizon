class AddArchiveToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :archive, :string, null: false
  end
end
