class UpdateSearchesView < ActiveRecord::Migration
  def up
    create_view_statement = <<-SQL
CREATE VIEW searches AS
SELECT
  id as result_id,
  'Challenge' as result_type,
  title,
  searchable
FROM challenges
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

    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute("DROP VIEW searches")
      ActiveRecord::Base.connection.execute(create_view_statement)
    end
  end
end
