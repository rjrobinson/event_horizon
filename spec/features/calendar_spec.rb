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

  let(:user) { FactoryGirl.create(
                 :user_with_calendar,
                 calendar_args: { cid: ENV["DEFAULT_CALENDAR_ID"] }
               ) }

  before(:each) do
    t = Time.new(2015, 02, 05, 19, 43)
    Timecop.travel(t)

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
