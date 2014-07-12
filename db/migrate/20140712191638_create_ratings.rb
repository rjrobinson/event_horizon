class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :assignment_id, null: false
      t.integer :clarity, null: false
      t.integer :helpfulness, null: false
      t.text :comment

      t.timestamps
    end

    add_index :ratings, [:user_id, :assignment_id], unique: true
    add_index :ratings, :assignment_id
  end
end
