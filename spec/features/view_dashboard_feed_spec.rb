require 'rails_helper'

feature "view dashboard feed", %Q{
  As an authenticated user
  I want to see an activity feed
  So that I can be informed of Launch Academy happenings
} do

  context 'signed in user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:submission) { FactoryGirl.create(:submission, user: user) }
    scenario 'sees feed for submission comment' do
      comment = FactoryGirl.create(:comment, submission: submission)
      sign_in_as(user)
      visit root_path

      expect(page).to have_content(comment.user.username)
      expect(page).to have_content(comment.body)
    end
  end
  scenario 'unauthenticated'
end
