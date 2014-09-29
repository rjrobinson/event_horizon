require "rails_helper"

feature "view lessons" do
  scenario "view list of available lessons" do
    lessons = FactoryGirl.create_list(:lesson, 3)

    visit lessons_path

    lessons.each do |lesson|
      expect(page).to have_link(lesson.title, href: lesson_path(lesson))
    end
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
