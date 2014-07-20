class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :challenges, :slug, unique: true
  end
end
