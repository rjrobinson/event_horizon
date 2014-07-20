class AddSearchableColumnToChallenges < ActiveRecord::Migration
  def up
    add_column :challenges, :searchable, :tsvector

    update_statement = <<-SQL
      UPDATE challenges
      SET searchable =
        to_tsvector('english', title || ' ' || body)
    SQL

    index_statement = <<-SQL
      CREATE INDEX index_challenges_on_searchable ON challenges
      USING gin(searchable)
    SQL

    trigger_statement = <<-SQL
      CREATE TRIGGER challenges_searchable_update BEFORE INSERT OR UPDATE
      ON challenges FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(searchable, 'pg_catalog.english', title, body)
    SQL

    ActiveRecord::Base.connection.execute(update_statement)
    ActiveRecord::Base.connection.execute(index_statement)
    ActiveRecord::Base.connection.execute(trigger_statement)
  end

  def down
    ActiveRecord::Base.connection.
      execute("DROP TRIGGER challenges_searchable_update ON challenges")
    ActiveRecord::Base.connection.
      execute("DROP INDEX index_challenges_on_searchable")

    remove_column :challenges, :searchable
  end
end
