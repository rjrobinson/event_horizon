require "rails_helper"

feature "search" do
  scenario "search challenge by keyword" do
    challenge = FactoryGirl.create(:challenge, title: "Blah", body: "foo")
    FactoryGirl.create(:challenge, title: "Bloop", body: "bar")

    visit root_path
    fill_in "query", with: "foo"
    click_button "Search"

    expect(page).to have_content("Found 1 result(s) for \"foo\".")
    expect(page).to have_link("Blah", challenge_path(challenge))
    expect(page).to_not have_content("Bloop")
  end

  scenario "no results found" do
    FactoryGirl.create(:challenge, title: "Blah", body: "foo")

    visit root_path
    fill_in "query", with: "baz"
    click_button "Search"

    expect(page).to have_content("No results found for \"baz\".")
    expect(page).to_not have_content("Blah")
  end
end
