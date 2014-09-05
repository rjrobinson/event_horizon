class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.integer :value, null: false
      t.integer :user_id, null: false
      t.integer :submission_id, null: false

      t.timestamps
    end

    add_index :downvotes, [:submission_id, :user_id], unique: true
    add_index :downvotes, :user_id
  end
end
