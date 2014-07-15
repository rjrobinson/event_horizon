class RemoveRoleFromEnrollments < ActiveRecord::Migration
  def up
    remove_column :enrollments, :role
  end

  def down
    add_column :enrollments, :role, :string, null: false, default: "student"
  end
end
