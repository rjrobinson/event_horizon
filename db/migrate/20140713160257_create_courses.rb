class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.integer :creator_id, null: false

      t.timestamps
    end

    add_index :courses, :creator_id
  end
end
