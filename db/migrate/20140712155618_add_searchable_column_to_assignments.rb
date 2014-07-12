class AddSearchableColumnToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :searchable, :tsvector

    update_statement = <<-SQL
      UPDATE assignments
      SET searchable =
        to_tsvector('english', title || ' ' || body)
    SQL

    index_statement = <<-SQL
      CREATE INDEX index_assignments_on_searchable ON assignments
      USING gin(searchable)
    SQL

    trigger_statement = <<-SQL
      CREATE TRIGGER assignments_searchable_update BEFORE INSERT OR UPDATE
      ON assignments FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(searchable, 'pg_catalog.english', title, body)
    SQL

    ActiveRecord::Base.connection.execute(update_statement)
    ActiveRecord::Base.connection.execute(index_statement)
    ActiveRecord::Base.connection.execute(trigger_statement)
  end

  def down
    ActiveRecord::Base.connection.
      execute("DROP TRIGGER assignments_searchable_update ON assignments")
    ActiveRecord::Base.connection.
      execute("DROP INDEX index_assignments_on_searchable")

    remove_column :assignments, :searchable
  end
end
