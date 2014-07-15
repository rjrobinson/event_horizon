class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.string :role, null: false, default: "student"

      t.timestamps
    end

    add_index :enrollments, [:user_id, :course_id], unique: true
    add_index :enrollments, :course_id
  end
end
