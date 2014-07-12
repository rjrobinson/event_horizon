require "rails_helper"

describe RatingsController do
  let(:assignment) { FactoryGirl.create(:assignment) }

  describe "POST create" do
    it "prevents unauthorized users from rating" do
      post :create, assignment_slug: assignment.slug, rating: {
        helpfulness: 3, clarity: 3
      }

      expect(response).to be_a_redirect
      expect(Rating.count).to eq(0)
    end
  end

  describe "PUT update" do
    it "prevents unauthorized users from rating" do
      rating = FactoryGirl.create(:rating, helpfulness: 1)

      put :update, id: rating.id, assignment_slug: assignment.slug, rating: {
        helpfulness: 5, clarity: 3
      }

      expect(response).to be_a_redirect
      rating.reload
      expect(rating.helpfulness).to eq(1)
    end
  end
end
