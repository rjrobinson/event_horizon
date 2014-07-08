class CreateSourceFiles < ActiveRecord::Migration
  def change
    create_table :source_files do |t|
      t.integer :submission_id, null: false
      t.string :filename, null: false, default: "untitled.txt"
      t.text :body, null: false

      t.timestamps
    end

    add_index :source_files, :submission_id
  end
end
