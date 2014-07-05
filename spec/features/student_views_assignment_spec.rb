require "rails_helper"

feature "student views assignment" do

  scenario "view a list of available assignments" do
    assignments = FactoryGirl.create_list(:assignment, 3)

    visit assignments_path

    assignments.each do |assignment|
      expect(page).to have_link(assignment.title, assignment_path(assignment))
    end
  end

  scenario "view an individual assignment rendered in markdown" do
    assignment = FactoryGirl.create(
      :assignment, body: "## Foo\n\nbar\n\n* item 1\n* item 2")

    visit assignment_path(assignment)

    expect(page).to have_content(assignment.title)
    expect(page).to have_selector("h2", "Foo")
    expect(page).to have_selector("p", "bar")
    expect(page).to have_selector("li", "item 1")
    expect(page).to have_selector("li", "item 2")
  end

end
