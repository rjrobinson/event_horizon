class AddArticlesToSearch < ActiveRecord::Migration
  def up
    create_view_statement = <<-SQL
CREATE VIEW searches AS
SELECT
  challenges.id AS result_id,
  'Challenge'::character varying AS result_type,
  challenges.title,
  challenges.searchable
FROM challenges

UNION

SELECT
  articles.id AS result_id,
  'Article'::character varying AS result_type,
  articles.title,
  articles.searchable
FROM articles
SQL

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DROP VIEW searches")
      ActiveRecord::Base.connection.execute(create_view_statement)
    end
  end

  def down
    create_view_statement = <<-SQL
CREATE VIEW searches AS
SELECT
  challenges.id AS result_id,
  'Challenge'::character varying AS result_type,
  challenges.title,
  challenges.searchable
FROM challenges
SQL

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DROP VIEW searches")
      ActiveRecord::Base.connection.execute(create_view_statement)
    end
  end
end
