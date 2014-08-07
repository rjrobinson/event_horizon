FactoryGirl.define do
  factory :assignment do
    sequence(:title) { |n| "Assignment #{n}" }
    sequence(:slug) { |n| "assignment-#{n}" }
    body "# Header\n\nThis is an assignment."
  end

  factory :challenge do
    sequence(:title) { |n| "Challenge #{n}" }
    sequence(:slug) { |n| "challenge-#{n}" }
    body "# Header\n\nThis is a challenge."
  end

  factory :comment do
    user
    submission
    body "Needs more cow-bell."
  end

  factory :course do
    sequence(:title) { |n| "Course #{n}" }
    association :creator, factory: :admin
  end

  factory :enrollment do
    user
    course
  end

  factory :rating do
    user
    assignment
    helpfulness 4
    clarity 2
    comment "Confusing."
  end

  factory :submission do
    challenge
    user

    archive do
      Rack::Test::UploadedFile.new(Rails.root.join("spec/data/one_file.tar.gz"))
    end

    factory :submission_with_two_file_archive do
      archive do
        Rack::Test::UploadedFile.new(
          Rails.root.join("spec/data/two_files.tar.gz"))
      end
    end

    factory :submission_with_file do
      after(:create) do |submission|
        FactoryGirl.create(:source_file, submission: submission)
      end
    end
  end

  factory :source_file do
    submission
    filename "foo.rb"
    body "2 + 2 == 5\n"
  end

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
