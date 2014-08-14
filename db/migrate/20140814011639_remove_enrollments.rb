class RemoveEnrollments < ActiveRecord::Migration
  def up
    drop_table :enrollments
  end

  def down
    create_table :enrollments do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.timestamps
    end

    add_index :enrollments, :course_id
    add_index :enrollments, [:user_id, :course_id], unique: true
  end
end
