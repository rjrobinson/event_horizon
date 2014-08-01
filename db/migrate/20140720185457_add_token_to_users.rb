class AddTokenToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def up
    add_column :users, :token, :string

    User.all.each do |user|
      user.token = SecureRandom.urlsafe_base64
      user.save!
    end

    change_column :users, :token, :string, null: false
  end

  def down
    remove_column :users, :token
  end
end
