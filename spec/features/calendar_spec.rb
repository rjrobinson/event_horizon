require "rails_helper"

feature "calendar", %(
  As a user on my dashboard
  I want to see upcoming events
  So that I can be informed about the happenings of the cohort.
), :vcr do

  # Acceptance Criteria:
  # - [x] I can see today and tomorrow's events
  # - [x] Events that have already started are shown in a lesser
  #   visual priority
  # - [x] I can click on an event and it links to the event in
  #   the calendar

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    membership = FactoryGirl.create(:team_membership, user: user)
    team = membership.team
    calendar = FactoryGirl.create(:calendar, cid: ENV["DEFAULT_CALENDAR_ID"])
    team.calendar = calendar
    team.save
    sign_in_as(user)
  end

  scenario "user sees event information" do
    visit dashboard_path

    expect(page).to have_content("Friday, February 6 at 09:30")
    expect(page).to have_link("Community: MassDigI Game Challenge")
  end

  scenario "events that have already started have a class of '.past-event'" do
    visit dashboard_path

    expect(page).to have_css("table.calendar tr.past-event")
    within("tr.past-event") do
      expect(page).to have_content("Past Event For Testing")
    end
  end

end
