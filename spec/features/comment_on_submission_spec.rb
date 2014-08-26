require "rails_helper"

feature "comment on submission" do
  let(:submission) { FactoryGirl.create(:submission_with_file) }

  context "as an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before :each do
      sign_in_as(admin)
    end

    scenario "comment on submission in general" do
      visit submission_path(submission)

      fill_in "Comment", with: "Needs more cow-bell."
      click_button "Submit"

      expect(page).to have_content("Comment saved.")
      expect(page).to have_content("#{admin.username} commented")
      expect(page).to have_content("Needs more cow-bell.")
    end

    it "comment on specific file and line" do
      file = FactoryGirl.create(:source_file,
                                body: "foo = 1\nbar = 2\nputs foo + bar")

      visit submission_path(file.submission)

      fill_in "Comment", with: "Needs more cow-bell."
      fill_in "Line Number", with: "1"
      select file.filename, from: "Filename"
      click_button "Submit"

      expect(page).to have_content("#{admin.username} commented")
      expect(page).to order_text("foo = 1", "Needs more cow-bell.")
      expect(page).to order_text("Needs more cow-bell.", "bar = 2")
    end

    scenario "redisplay form with error if comment is blank" do
      visit submission_path(submission)

      fill_in "Comment", with: ""
      click_button "Submit"

      expect(page).to_not have_content("#{admin.username} commented")
      expect(page).to have_content("can't be blank")
      expect(Comment.count).to eq(0)
    end
  end
end
