class CreateSearchableView < ActiveRecord::Migration
  def up
    create_view_statement = <<-SQL
CREATE VIEW searches AS
SELECT
  id as result_id,
  'Assignment' as result_type,
  title,
  searchable
FROM assignments

UNION

SELECT
  id as result_id,
  'Challenge' as result_type,
  title,
  searchable
FROM challenges
SQL

    ActiveRecord::Base.connection.execute(create_view_statement)
  end

  def down
    ActiveRecord::Base.connection.execute("DROP VIEW searches")
  end
end
