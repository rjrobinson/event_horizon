class AddTeamIndexToAnnouncements < ActiveRecord::Migration
  def change
    add_index :announcements, :team_id
  end
end
