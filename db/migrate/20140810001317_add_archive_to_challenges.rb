class AddArchiveToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :archive, :string, null: false
  end
end
