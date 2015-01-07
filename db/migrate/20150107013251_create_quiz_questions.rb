class CreateQuizQuestions < ActiveRecord::Migration
  def change
    create_table :quiz_questions do |t|
      t.text :prompt, null: false
      t.integer :quiz_id, null: false

      t.timestamps
    end

    add_index :quiz_questions, :quiz_id
  end
end
