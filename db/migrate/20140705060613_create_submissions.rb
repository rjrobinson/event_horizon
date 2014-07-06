class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id, null: false
      t.integer :assignment_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :submissions, :user_id
    add_index :submissions, :assignment_id
  end
end
