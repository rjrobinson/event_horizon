FactoryGirl.define do
  factory :enrollment do
    user
    course
    role "student"
  end
end
