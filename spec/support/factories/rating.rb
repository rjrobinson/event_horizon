FactoryGirl.define do
  factory :rating do
    user
    assignment
    helpfulness 4
    clarity 2
    comment "Confusing."
  end
end
