FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Course #{n}" }
    association :creator, factory: :admin
  end
end
