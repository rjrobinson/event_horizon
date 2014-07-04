require "rails_helper"

feature "student views assignment" do

  scenario "view a list of available assignments" do
    assignments = FactoryGirl.create_list(:assignment, 3)

    visit assignments_path

    assignments.each do |assignment|
      expect(page).to have_link(assignment.title, assignment_path(assignment))
    end
  end

end
