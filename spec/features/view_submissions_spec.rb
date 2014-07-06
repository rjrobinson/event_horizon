require "rails_helper"

feature "view submissions" do
  context "as a student" do
    let(:student) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(student)
    end

    scenario "see only my submissions for an assignment" do
      assignment = FactoryGirl.create(:assignment)

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
end
