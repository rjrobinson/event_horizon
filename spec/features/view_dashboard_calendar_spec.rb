require "rails_helper"

feature "view dashboard calendar" do
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

  scenario "user sees event information" do
    pending "override Calendar default_start_time default_end_time methods"
    sign_in_as(user)
    visit dashboard_path
    expect(page).to have_content("Monday, February 9 at 19:00")
    expect(page).to have_link("Community: Boston MySQL Monthly Meetup")
  end

  scenario "events that have already started have a class of '.past-event'" do
    pending "override Calendar default_start_time default_end_time methods"
    sign_in_as(user)
    visit dashboard_path
    expect(page).to have_css("table.calendar tr.past-event")
    within("tr.past-event") do
      expect(page).to have_content("Past Event")
    end
  end
end
