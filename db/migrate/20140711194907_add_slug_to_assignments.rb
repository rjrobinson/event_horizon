class AddSlugToAssignments < ActiveRecord::Migration
  class Assignment < ActiveRecord::Base; end

  def up
    add_column :assignments, :slug, :string

    ActiveRecord::Base.transaction do
      Assignment.all.each do |assignment|
        assignment.slug = assignment.title.downcase.split.join("-")
        assignment.save!
      end
    end

    change_column :assignments, :slug, :string, null: false
    add_index :assignments, :slug, unique: true
  end

  def down
    remove_index :assignments, :slug
    remove_column :assignments, :slug
  end
end
