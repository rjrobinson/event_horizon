require "rails_helper"

feature "view courses", focus: true do
  context "as a guest" do
    scenario "require login to view courses" do
      visit root_path
      expect(page).to_not have_link("Courses", courses_path)

      visit courses_path
      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content("Courses")
    end
  end

  context "as a member" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "view enrolled courses" do
      enrollments = FactoryGirl.create_list(:enrollment, 2, user: user)
      other_courses = FactoryGirl.create_list(:course, 2)

      visit root_path
      click_link "Courses"

      enrollments.each do |enrollment|
        course = enrollment.course
        expect(page).to have_link(course.title, course_path(course))
      end

      other_courses.each do |course|
        expect(page).to_not have_link(course.title, course_path(course))
      end
    end
  end

  context "as an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before :each do
      sign_in_as(admin)
    end

    scenario "view all courses" do
      courses = FactoryGirl.create_list(:course, 3)

      visit root_path
      click_link "Courses"

      courses.each do |course|
        expect(page).to have_link(course.title, course_path(course))
      end
    end
  end
end
