require "rails_helper"

feature "view submissions" do
  let(:challenge) { FactoryGirl.create(:challenge) }

  context "as a student" do
    let(:student) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(student)
    end

    scenario "see only my submissions for a challenge" do
      my_submissions = FactoryGirl.
        create_list(:submission, 2, challenge: challenge, user: student)
      other_submissions = FactoryGirl.
        create_list(:submission, 2, challenge: challenge)

      visit challenge_submissions_path(challenge)

      my_submissions.each do |submission|
        expect(page).to have_link_href(submission_path(submission))
      end

      other_submissions.each do |submission|
        expect(page).to_not have_link_href(submission_path(submission))
      end
    end
  end

  context "as an instructor" do
    let(:instructor) { FactoryGirl.create(:instructor) }

    before :each do
      sign_in_as(instructor)
    end

    scenario "see all of the submissions for an challenge" do
      submissions = FactoryGirl.
        create_list(:submission, 3, challenge: challenge)

      visit challenge_submissions_path(challenge)

      submissions.each do |submission|
        expect(page).to have_link_href(submission_path(submission))
      end
    end

    scenario "view submission from student" do
      submission = FactoryGirl.create(:submission_with_source,
                                      challenge: challenge)

      visit submission_path(submission)

      expect(page).to have_content("Submission for #{challenge.title}")
      expect(page).to have_content("Submitted by #{submission.user.username}")
    end
  end

  context "as a guest" do
    scenario "redirect to login" do
      visit challenge_submissions_path(challenge)

      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content("Submissions for #{challenge.title}")
    end
  end
end
