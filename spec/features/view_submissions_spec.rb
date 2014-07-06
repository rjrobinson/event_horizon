require "rails_helper"

feature "view submissions" do
  let(:assignment) { FactoryGirl.create(:assignment) }

  context "as a student" do
    let(:student) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(student)
    end

    scenario "see only my submissions for an assignment" do
      my_submissions = FactoryGirl.
        create_list(:submission, 2, assignment: assignment, user: student)
      other_submissions = FactoryGirl.
        create_list(:submission, 2, assignment: assignment)

      visit assignment_submissions_path(assignment)

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

    scenario "see all of the submissions for an assignment" do
      submissions = FactoryGirl.
        create_list(:submission, 3, assignment: assignment)

      visit assignment_submissions_path(assignment)

      submissions.each do |submission|
        expect(page).to have_link_href(submission_path(submission))
      end
    end

    scenario "view submission from student" do
      submission = FactoryGirl.create(:submission, assignment: assignment)

      visit submission_path(submission)

      expect(page).to have_content("Submission for #{assignment.title}")
      expect(page).to have_content("Submitted by #{submission.user.username}")
    end
  end

  context "as a guest" do
    scenario "redirect to login" do
      visit assignment_submissions_path(assignment)

      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content("Submissions for #{assignment.title}")
    end
  end
end
