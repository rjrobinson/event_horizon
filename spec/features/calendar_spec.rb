require "rails_helper"

feature "calendar", %(
  As a user on my dashboard
  I want to see upcoming events
  So that I can be informed about the happenings of the cohort.

  Acceptance Criteria:
  - [x] I can see today and tomorrow's events
  - [x] Events that have already started are shown in a lesser
    visual priority
  - [x] I can click on an event and it links to the event in
    the calendar
) do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in_as(user)
  end

  scenario "user sees event information" do
    calendar_event = FactoryGirl.create(:calendar_event)

    visit dashboard_path

    start_date = calendar_event.from.to_formatted_s(:day_and_month)
    start_time = calendar_event.from.to_formatted_s(:hour_and_minute)
    end_time = calendar_event.to.to_formatted_s(:hour_and_minute)

    expect(page).to have_content(start_date)
    expect(page).to have_content(start_time)
    expect(page).to have_content(end_time)
    expect(page).to have_content(calendar_event.title)
  end

  scenario "user sees today's and tomorrow's events" do
    event_today = FactoryGirl.create(:calendar_event,
      from: 1.hour.from_now)
    event_tomorrow = FactoryGirl.create(:calendar_event,
      from: 1.day.from_now)

    visit dashboard_path

    expect(page).to have_content(event_today.title)
    expect(page).to have_content(event_tomorrow.title)
  end

  scenario "user should not see old events" do
    past_event = FactoryGirl.create(:calendar_event,
      from: 25.hours.ago)

    visit dashboard_path

    expect(page).to_not have_content(past_event.title)
  end

  scenario "user should not see events far into the future" do
    future_event = FactoryGirl.create(:calendar_event,
      from: 2.days.from_now)

    visit dashboard_path

    expect(page).to_not have_content(future_event.title)
  end

  scenario "events that have already started have a class of '.past-event'" do
    FactoryGirl.create(:calendar_event, from: 1.hour.ago, to: 1.hour.from_now)

    visit dashboard_path

    expect(page).to have_css("table.calendar tr.past-event")
  end

  scenario "events link to google calendar events" do
    event = FactoryGirl.create(:calendar_event,
      url: "http://www.google.com/calendar")

    visit dashboard_path

    expect(page).to have_link(event.title)
  end

end
