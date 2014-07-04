require "rails_helper"

feature "student views assignment" do

  scenario "view a list of available assignments" do
    assignments = FactoryGirl.create_list(:assignment, 3)

    visit assignments_path

    assignments.each do |assignment|
      expect(page).to have_link(assignment.title, assignment_path(assignment))
    end
  end

  scenario "view an individual assignment" do
    assignment = FactoryGirl.create(:assignment)

    visit assignment_path(assignment)

    expect(page).to have_content(assignment.title)
    expect(page).to have_content(assignment.body)
  end

end
