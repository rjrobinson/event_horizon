class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :team_id, null: false

      t.timestamps
    end
  end
end
