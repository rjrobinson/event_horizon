class AddUniqueIndexToLowercaseUsernamesOnUsers < ActiveRecord::Migration
  def up
    remove_index :users, :username

    execute <<-SQL
      CREATE UNIQUE INDEX index_users_on_lowercase_username
        ON users
        USING btree (lower(username))
    SQL
  end

  def down
    add_index :users, :username, unique: true

    execute <<-SQL
      DROP INDEX index_users_on_lowercase_username
    SQL
  end
end
