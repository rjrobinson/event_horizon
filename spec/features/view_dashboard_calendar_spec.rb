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

  before(:each) do
    datetime = DateTime.parse("2015/02/09")
    start_time = datetime.beginning_of_day
    end_time = datetime.end_of_day + 1.day

    allow_any_instance_of(Calendar).to receive(:default_start_time)
      .and_return(start_time)

    allow_any_instance_of(Calendar).to receive(:default_end_time)
      .and_return(end_time)
  end

  scenario "user sees event information" do
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
