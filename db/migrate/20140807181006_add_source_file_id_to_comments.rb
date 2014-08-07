class AddSourceFileIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :source_file_id, :integer

    add_index :comments, :source_file_id
  end
end
