class AddDeliveredToComments < ActiveRecord::Migration
  def change
    add_column :comments, :delivered, :boolean, null: false, default: false
    add_index :comments, :delivered, where: "delivered = false"
  end
end
