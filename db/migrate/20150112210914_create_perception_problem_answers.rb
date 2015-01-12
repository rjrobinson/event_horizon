class CreatePerceptionProblemAnswers < ActiveRecord::Migration
  def change
    create_table :perception_problem_answers do |t|
      t.integer :user_id, null: false
      t.integer :perception_problem_id, null: false
      t.integer :perception_problem_option_id, null: false

      t.timestamps
    end

    add_index :perception_problem_answers, :user_id
    add_index :perception_problem_answers, :perception_problem_id
    add_index :perception_problem_answers, :perception_problem_option_id, name: "boop"
  end
end
