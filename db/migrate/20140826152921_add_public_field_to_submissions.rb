class AddPublicFieldToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :public, :boolean, null: false, default: false
  end
end
