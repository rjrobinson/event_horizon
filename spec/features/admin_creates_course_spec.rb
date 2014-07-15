require "rails_helper"

feature "admin creates course" do
  context "as an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before :each do
      sign_in_as(admin)
    end

    scenario "successfully fill out new course form" do
      visit new_course_path

      fill_in "Title", with: "Web Development with Rails"
      click_button "Create Course"

      expect(page).to have_content("New course created.")
      expect(page).to have_content("Web Development with Rails")

      expect(Course.count).to eq(1)

      course = Course.first
      expect(course.creator).to eq(admin)
    end

    scenario "fail to fill in form displays error" do
      visit new_course_path
      click_button "Create Course"

      expect(page).to have_content("Title can't be blank")
      expect(Course.count).to eq(0)
    end

    scenario "view link to create new course" do
      visit courses_path
      expect(page).to have_link("New Course", new_course_path)
    end
  end

  context "as a non-admin user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "cannot view link to create new course" do
      visit courses_path
      expect(page).to_not have_link("New Course", new_course_path)
    end
  end
end
