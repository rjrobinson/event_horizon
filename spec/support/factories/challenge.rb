FactoryGirl.define do
  factory :challenge do
    sequence(:title) { |n| "Challenge #{n}" }
    sequence(:slug) { |n| "challenge-#{n}" }
    body "# Header\n\nThis is a challenge."
  end
end
