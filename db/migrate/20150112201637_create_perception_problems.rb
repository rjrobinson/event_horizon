class CreatePerceptionProblems < ActiveRecord::Migration
  def change
    create_table :perception_problems do |t|
      t.text :prompt, null: false

      t.timestamps
    end
  end
end
