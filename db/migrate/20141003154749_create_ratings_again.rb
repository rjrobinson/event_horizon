class CreateRatingsAgain < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :lesson_id, null: false
      t.integer :clarity, null: false
      t.integer :helpfulness, null: false
      t.text :comment

      t.timestamps
    end

    add_index :ratings, [:user_id, :lesson_id], unique: true
    add_index :ratings, :lesson_id
  end
end
