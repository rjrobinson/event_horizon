class RemoveArticles < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("DROP VIEW searches")
    drop_table :articles
    drop_table :challenges
  end

  def down
    create_table :challenges do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.text :description
      t.tsvector :searchable
      t.string :archive, null: false

      t.timestamps
    end

    add_index :challenges, :slug, unique: true

    ActiveRecord::Base.connection.execute("CREATE INDEX index_challenges_on_searchable ON challenges USING gin (searchable)")

    ActiveRecord::Base.connection.execute("CREATE TRIGGER challenges_searchable_update BEFORE INSERT OR UPDATE ON challenges FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('searchable', 'pg_catalog.english', 'title', 'body')")

    create_table :articles do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.text :description
      t.tsvector :searchable

      t.timestamps
    end

    add_index :articles, :slug, unique: true

    ActiveRecord::Base.connection.execute("CREATE TRIGGER articles_searchable_update BEFORE INSERT OR UPDATE ON articles FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('searchable', 'pg_catalog.english', 'title', 'body')")

    ActiveRecord::Base.connection.execute("CREATE INDEX index_articles_on_searchable ON articles USING gin (searchable)")

    ActiveRecord::Base.connection.execute(<<SQL
CREATE VIEW searches AS
 SELECT challenges.id AS result_id,
    'Challenge'::character varying AS result_type,
    challenges.title,
    challenges.searchable
   FROM challenges
UNION
 SELECT articles.id AS result_id,
    'Article'::character varying AS result_type,
    articles.title,
    articles.searchable
   FROM articles;
SQL
)
  end
end
