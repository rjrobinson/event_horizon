class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
