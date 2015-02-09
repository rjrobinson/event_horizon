require "rails_helper"

feature "view dashboard calendar", :vcr do
  # As a user on my dashboard
  # I want to see upcoming events
  # So that I can be informed about the happenings of the cohort.

  # Acceptance Criteria:
  # - [x] I can see today and tomorrow's events
  # - [x] Events that have already started are shown in a lesser
  #   visual priority
  # - [x] I can click on an event and it links to the event in
  #   the calendar

  let(:user) do
    FactoryGirl.create(
      :user_with_calendar,
      calendar_args: { cid: ENV["DEFAULT_GOOGLE_CALENDAR_ID"] }
    )
  end

  before(:each) do
    sign_in_as(user)
    time = DateTime.parse("2015/02/09 17:55 -0500")
    Timecop.travel(time)
  end

  after(:each) do
    Timecop.return
  end

  scenario "user sees event information" do
    visit dashboard_path
    expect(page).to have_content("Monday, February 9 at 19:00")
    expect(page).to have_link("Community: Boston MySQL Monthly Meetup")
  end

  scenario "events that have already started have a class of '.past-event'" do
    visit dashboard_path
    expect(page).to have_css("table.calendar tr.past-event")
    within("tr.past-event") do
      expect(page).to have_content("Past Event")
    end
  end
end
