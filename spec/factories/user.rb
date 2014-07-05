FactoryGirl.define do

  factory :user do
    provider "github"
    sequence(:uid) { |n| n }
    sequence(:username) { |n| "george_michael_#{n}" }
    sequence(:email) { |n| "gm#{n}@example.com" }
    sequence(:name) { |n| "George Michael #{n}" }
  end

end
