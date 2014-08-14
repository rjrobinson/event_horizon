class RemoveCourses < ActiveRecord::Migration
  def up
    drop_table :courses
  end

  def down
    create_table :courses do |t|
      t.string :title, null: false
      t.integer :creator_id, null: false
      t.timestamps
    end

    add_index :courses, :creator_id
  end
end
