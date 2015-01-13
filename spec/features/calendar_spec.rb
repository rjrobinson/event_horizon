require "rails_helper"

feature "calendar", %(
  As a user on my dashboard
  I want to see upcoming events
  So that I can be informed about the happenings of the cohort.

  Acceptance Criteria:
  - [] I can see today and tomorrow's events
  - [] Events that have already started are shown in a lesser
    visual priority
  - [] I can click on an event and it links to the event in
    the calendar
) do

  let(:user) { FactoryGirl.create(:user) }
  let!(:calendar_event) { FactoryGirl.create(:calendar_event) }

  scenario "user sees calendar event", focus: true do
    sign_in_as(user)
    visit dashboard_path
    expect(page).to have_content(calendar_event.from)
    expect(page).to have_content(calendar_event.to)
    expect(page).to have_content(calendar_event.title)
  end

end
