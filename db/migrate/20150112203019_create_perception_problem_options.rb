class CreatePerceptionProblemOptions < ActiveRecord::Migration
  def change
    create_table :perception_problem_options do |t|
      t.integer :perception_problem_id, null: false
      t.text :body, null: false
      t.boolean :correct, null: false

      t.timestamps
    end

    add_index :perception_problem_options, :perception_problem_id
  end
end
