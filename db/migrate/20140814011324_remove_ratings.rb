class RemoveRatings < ActiveRecord::Migration
  def up
    drop_table :ratings
  end

  def down
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :assignment_id, null: false
      t.integer :clarity, null: false
      t.integer :helpfulness, null: false
      t.text :comment

      t.timestamps
    end

    add_index :ratings, :assignment_id
    add_index :ratings, [:user_id, :assignment_id], unique: true
  end
end
