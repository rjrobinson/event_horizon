FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| n.to_s }
    sequence(:username) { |n| "george_michael_#{n}" }
    sequence(:email) { |n| "gm#{n}@example.com" }
    sequence(:name) { |n| "George Michael #{n}" }
    role "member"

    factory :instructor do
      role "instructor"
    end

    factory :admin do
      role "admin"
    end
  end
end
