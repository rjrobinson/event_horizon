require "rails_helper"

feature "search" do
  scenario "search assignment by keyword" do
    assignment = FactoryGirl.create(:assignment, title: "Blah", body: "foo")
    FactoryGirl.create(:assignment, title: "Bloop", body: "bar")

    visit root_path
    fill_in "query", with: "foo"
    click_button "Search"

    expect(page).to have_content("Found 1 result(s) for \"foo\".")
    expect(page).to have_link("Blah", assignment_path(assignment))
    expect(page).to_not have_content("Bloop")
  end

  scenario "search assignments and challenges" do
    assignment = FactoryGirl.create(:assignment, title: "Blah", body: "foo")
    challenge = FactoryGirl.create(:challenge, title: "Fizzbuzz", body: "foo")

    visit root_path
    fill_in "query", with: "foo"
    click_button "Search"

    expect(page).to have_content("Found 2 result(s) for \"foo\".")
    expect(page).to have_link("Blah", assignment_path(assignment))
    expect(page).to have_link("Fizzbuzz", challenge_path(challenge))
  end

  scenario "no results found" do
    FactoryGirl.create(:assignment, title: "Blah", body: "foo")

    visit root_path
    fill_in "query", with: "baz"
    click_button "Search"

    expect(page).to have_content("No results found for \"baz\".")
    expect(page).to_not have_content("Blah")
  end
end
