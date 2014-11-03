class CreateAssignmentsAgain < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :team_id, null: false
      t.integer :lesson_id, null: false
      t.datetime :due_on, null: false
      t.boolean :required, null: false, default: true

      t.timestamps
    end

    add_index :assignments, :team_id
    add_index :assignments, :lesson_id
  end
end
