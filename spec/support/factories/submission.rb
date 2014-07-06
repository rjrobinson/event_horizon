FactoryGirl.define do

  factory :submission do
    assignment
    user
    body "2 + 2 == 5"
  end

end
