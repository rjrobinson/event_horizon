require "rails_helper"

feature "view articles" do
  scenario "view list of available articles" do
    articles = FactoryGirl.create_list(:article, 3)

    visit articles_path

    articles.each do |article|
      expect(page).to have_link(article.title, article_path(article))
    end
  end
end
