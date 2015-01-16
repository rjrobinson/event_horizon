# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_item do
    subject_id 1
    subject_type "MyString"
    recipient_id 1
  end
end
