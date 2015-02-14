require 'rails_helper'

feature 'question comments' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }

    scenario 'I can create a comment on a question' do
      sign_in_as user
      visit question_path(question)

      click_on 'add comment'

      fill_in 'Body', with: 'Please provide more details'
      click_on 'create comment'

      expect(page).to have_content('Please provide more details')
    end
  end

  context 'as a visitor' do
    let(:question) { FactoryGirl.create(:question) }

    scenario 'I cannot create a comment for a question' do
      visit question_path(question)

      click_on 'add comment'

      fill_in 'Body', with: 'Please provide more details'
      click_on 'create comment'

      expect(page).to_not have_content('Please provide more details')
      expect(page).to have_content('You need to sign in before continuing.')
    end
  end
end
