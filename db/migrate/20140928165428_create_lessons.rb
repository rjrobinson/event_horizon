class CreateLessons < ActiveRecord::Migration
  def up
    create_table :lessons do |t|
      t.string :type, null: false
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.text :description
      t.tsvector :searchable
      t.string :archive

      t.timestamps
    end

    add_index :lessons, :slug, unique: true

    update_statement = <<-SQL
      UPDATE lessons
      SET searchable =
        to_tsvector('english', title || ' ' || body || ' ' || coalesce(description, ''))
    SQL

    index_statement = <<-SQL
      CREATE INDEX index_lessons_on_searchable ON lessons
      USING gin(searchable)
    SQL

    trigger_statement = <<-SQL
      CREATE TRIGGER lessons_searchable_update BEFORE INSERT OR UPDATE
      ON lessons FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(searchable, 'pg_catalog.english', title, body, description)
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

    remove_index :lessons, :slug
    drop_table :lessons
  end
end
