require "rails_helper"

feature "view articles" do
  scenario "view list of available articles" do
    articles = FactoryGirl.create_list(:article, 3)

    visit articles_path

    articles.each do |article|
      expect(page).to have_link(article.title, article_path(article))
    end
  end

  scenario "view individual assignment" do
    article = FactoryGirl.create(
      :article, body: "## Foo\n\nbar\n\n* item 1\n*item 2")

    visit article_path(article)

    expect(page).to have_content(article.title)
    expect(page).to have_selector("h2", "Foo")
    expect(page).to have_selector("p", "bar")
    expect(page).to have_selector("li", "item 1")
    expect(page).to have_selector("li", "item 2")
  end
end
