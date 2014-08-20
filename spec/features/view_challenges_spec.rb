require "rails_helper"

feature "views challenges" do
  scenario "view a list of available challenges" do
    challenges = FactoryGirl.create_list(:challenge, 3)

    visit challenges_path

    challenges.each do |challenge|
      expect(page).to have_link(challenge.title, challenge_path(challenge))
      expect(page).to have_content(challenge.description)
    end
  end

  scenario "view an individual challenge rendered in markdown" do
    challenge = FactoryGirl.create(
      :challenge, body: "## Foo\n\nbar\n\n* item 1\n* item 2")

    visit challenge_path(challenge)

    expect(page).to have_content(challenge.title)
    expect(page).to have_selector("h2", "Foo")
    expect(page).to have_selector("p", "bar")
    expect(page).to have_selector("li", "item 1")
    expect(page).to have_selector("li", "item 2")
  end
end
