class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name, null: false
      t.text :description
      t.integer :unit_id, null: false

      t.timestamps
    end

    add_index :quizzes, :unit_id
  end
end
