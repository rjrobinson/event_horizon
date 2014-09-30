class AddPositionToLessons < ActiveRecord::Migration
  class Lesson < ActiveRecord::Base; end

  def up
    add_column :lessons, :position, :integer
    Lesson.update_all(position: 1)
    change_column :lessons, :position, :integer, null: false
  end

  def down
    remove_column :lessons, :position
  end
end
