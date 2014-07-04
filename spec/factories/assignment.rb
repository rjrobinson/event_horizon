FactoryGirl.define do

  factory :assignment do
    sequence(:title) { |n| "Assignment #{n}" }
    body "# Header\n\nThis is an assignment."
  end

end
