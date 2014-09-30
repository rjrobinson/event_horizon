require "rails_helper"

feature "view lessons" do
  scenario "view list of available lessons" do
    middle_lesson = FactoryGirl.create(:lesson, position: 2)
    first_lesson = FactoryGirl.create(:lesson, position: 1)
    last_lesson = FactoryGirl.create(:lesson, position: 3)

    visit lessons_path

    expect(page).to have_link(
      first_lesson.title, href: lesson_path(first_lesson))
    expect(page).to have_link(
      middle_lesson.title, href: lesson_path(middle_lesson))
    expect(page).to have_link(
      last_lesson.title, href: lesson_path(last_lesson))

    expect(page).to order_text(first_lesson.title, middle_lesson.title)
    expect(page).to order_text(middle_lesson.title, last_lesson.title)
  end

  scenario "view individual lesson" do
    lesson = FactoryGirl.create(
      :lesson, body: "## Foo\n\nbar\n\n* item 1\n*item 2")

    visit lesson_path(lesson)

    expect(page).to have_content(lesson.title)
    expect(page).to have_selector("h2", "Foo")
    expect(page).to have_selector("p", "bar")
    expect(page).to have_selector("li", "item 1")
    expect(page).to have_selector("li", "item 2")
  end
end
