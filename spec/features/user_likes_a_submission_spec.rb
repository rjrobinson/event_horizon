require 'rails_helper'

feature 'user likes a submission', %q{

  As an Event Horizon user
  I would like to 'like' a submission
  So that the most liked submission is pushed
    to the top of the list.

} do

  # Acceptance Criteria:
  #  * User must have a submission for the assignment
  #  * User cannot 'like' their own submission
  #  * user cannot 'like' a submission more than once

  let!(:lesson) { FactoryGirl.create(:lesson) }
  let!(:user) { FactoryGirl.create(:submission, lesson: lesson).user }
  let!(:submission) { FactoryGirl.create(:submission, lesson: lesson, public: true) }

  scenario "user 'likes' someone else's submission", focus: true do
    sign_in_as user

    visit submission_path(submission)
    click_on 'Like'
    expect(page).to have_content('1 Like')
  end
end
