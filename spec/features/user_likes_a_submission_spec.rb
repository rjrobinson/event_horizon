require "rails_helper"

feature "user likes a submission", %q{

  As an Event Horizon user
  I would like to "like" a submission
  So that the most liked submission is pushed
    to the top of the list.

} do

  # Acceptance Criteria:
  #  * User cannot 'like' their own submission
  #  * user cannot 'like' a submission more than once

  let!(:lesson) { FactoryGirl.create(:lesson) }
  let!(:user) { FactoryGirl.create(:submission, lesson: lesson, public: true).user }
  let(:submission) { FactoryGirl.create(:submission, lesson: lesson, public: true) }

  before(:each) do
    sign_in_as user
  end

  scenario "user 'likes' someone else's submission" do
    visit submission_path(submission)
    click_on "Like"
    expect(page).to have_content('1 Like')
  end

  scenario "user attempts to 'like' their own submission" do
    visit submission_path(user.submissions.first)
    click_on "Like"
    expect(page).to have_content("Don't be an egotist.")
  end

  scenario "user attempts to 'like' a submission twice" do
    visit submission_path(submission)
    click_on "Like"
    click_on "Like"
    expect(page).to have_content("You already 'liked' that.")
  end

  scenario "the most liked submission is at the top of the list", focus: true do
    other_submission = FactoryGirl.create(:submission, lesson: lesson, public: true)
    best_submission = submission
    3.times { FactoryGirl.create(:like, submission: best_submission)}

    visit lesson_submissions_path(best_submission.lesson)

    expect(page.body.index(best_submission.user.username))
      .to be < (page.body.index(other_submission.user.username))
  end

end
