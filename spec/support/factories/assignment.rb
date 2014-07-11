FactoryGirl.define do

  factory :assignment do
    sequence(:title) { |n| "Assignment #{n}" }
    sequence(:slug) { |n| "assignment-#{n}" }
    body "# Header\n\nThis is an assignment."
  end

end
