class CreateAnnouncementReceipts < ActiveRecord::Migration
  def change
    create_table :announcement_receipts do |t|
      t.integer :user_id, null: false
      t.integer :announcement_id, null: false

      t.timestamps
    end
  end
end
