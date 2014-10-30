require 'rails_helper'

feature 'admin downloads a submission', %q{

  As an Event Horizon chief black hole explorer,
  I would like to retrieve the 1's and 0's of a users submission,
  So that I might execute it locally to determine a cosmonaut's success.

} do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:submission) { FactoryGirl.create(:submission) }

  scenario 'admin visits submission page, sees link to download', focus: true do
    sign_in_as(admin)
    visit submission_path(submission)
    expect(page).to have_button('Download Submission')
  end

end
