require "rails_helper"

feature "search assignments" do
  scenario "successful matches with keyword" do
    assignment_a = FactoryGirl.create(:assignment, title: "Blah", body: "foo")
    assignment_b = FactoryGirl.create(:assignment, title: "Bloop", body: "bar")

    visit root_path
    fill_in "query", with: "foo"
    click_button "Search"

    expect(page).to have_content("Found 1 result(s).")
    expect(page).to have_link("Blah", assignment_path(assignment_a))
    expect(page).to_not have_content("Bloop")
  end

  scenario "no results found" do
    assignment = FactoryGirl.create(:assignment, title: "Blah", body: "foo")

    visit root_path
    fill_in "query", with: "baz"
    click_button "Search"

    expect(page).to have_content("No results found.")
    expect(page).to_not have_content("Blah")
  end
end
