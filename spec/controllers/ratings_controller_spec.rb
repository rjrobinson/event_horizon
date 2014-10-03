require "rails_helper"

describe RatingsController do
  let(:lesson) { FactoryGirl.create(:lesson) }

  describe "POST create" do
    it "prevents unauthorized users from rating" do
      post :create, lesson_slug: lesson.slug, rating: {
        clarity: "1", helpfulness: "1"
      }

      expect(response).to be_a_redirect
      expect(Rating.count).to eq(0)
    end
  end

  describe "PUT update" do
    it "prevents unauthorized users from updating" do
      rating = FactoryGirl.create(:rating,
        lesson: lesson, clarity: 5, helpfulness: 5)

      put :update, lesson_slug: lesson.slug, id: rating.id, rating: {
        clarity: "1", helpfulness: "1"
      }

      expect(response).to be_a_redirect

      rating.reload
      expect(rating.clarity).to eq(5)
      expect(rating.helpfulness).to eq(5)
    end
  end
end
