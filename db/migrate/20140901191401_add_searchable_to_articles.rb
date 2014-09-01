class AddSearchableToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :searchable, :tsvector

    update_statement = <<-SQL
      UPDATE articles
      SET searchable =
        to_tsvector('english', title || ' ' || body)
    SQL

    index_statement = <<-SQL
      CREATE INDEX index_articles_on_searchable ON articles
      USING gin(searchable)
    SQL

    trigger_statement = <<-SQL
      CREATE TRIGGER articles_searchable_update BEFORE INSERT OR UPDATE
      ON articles FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(searchable, 'pg_catalog.english', title, body)
    SQL

    ActiveRecord::Base.connection.execute(update_statement)
    ActiveRecord::Base.connection.execute(index_statement)
    ActiveRecord::Base.connection.execute(trigger_statement)
  end

  def down
    ActiveRecord::Base.connection.
      execute("DROP TRIGGER articles_searchable_update ON articles")
    ActiveRecord::Base.connection.
      execute("DROP INDEX index_articles_on_searchable")

    remove_column :articles, :searchable
  end
end
