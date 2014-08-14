class RemoveAssignments < ActiveRecord::Migration
  def up
    drop_table :assignments
  end

  def down
    create_table :assignments do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :body, null: false
      t.tsvector :searchable
      t.timestamps
    end

    add_index :assignments, :slug, unique: true

    index_statement = <<-SQL
      CREATE INDEX index_assignments_on_searchable ON assignments
      USING gin(searchable)
    SQL

    trigger_statement = <<-SQL
      CREATE TRIGGER assignments_searchable_update BEFORE INSERT OR UPDATE
      ON assignments FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(searchable, 'pg_catalog.english', title, body)
    SQL

    ActiveRecord::Base.connection.execute(index_statement)
    ActiveRecord::Base.connection.execute(trigger_statement)
  end
end
