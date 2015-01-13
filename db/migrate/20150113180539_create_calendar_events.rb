class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.string :title, null: false
      t.datetime :from, null: false
      t.datetime :to, null: false

      t.timestamps
    end
  end
end
