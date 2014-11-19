class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :submission_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :likes, [:submission_id, :user_id], unique: true
  end
end
