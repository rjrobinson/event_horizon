require 'rails_helper'


feature "admin can see average ratings" do

  let(:admin) { FactoryGirl.create(:admin) }

  scenario "admin visits lessons page", focus: true do
    sign_in_as(admin)
    lesson = FactoryGirl.create(:lesson)
    FactoryGirl.create(:rating, lesson: lesson, clarity: 5, helpfulness: 5)
    FactoryGirl.create(:rating, lesson: lesson, clarity: 5, helpfulness: 2)

    visit lessons_path
    expect(page).to have_content("Clarity Score: 5")
    expect(page).to have_content("Helpfulness Score: 3.5")
    expect(page).to have_content("Reviews: 2")
  end

end

