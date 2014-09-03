class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.integer :user_id, null: false
      t.integer :submission_id, null: false

      t.timestamps
    end

    add_index :votes, [:submission_id, :user_id], unique: true
    add_index :votes, :user_id
  end
end
