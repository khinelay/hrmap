FactoryGirl.define do
  factory :department do
    sequence(:name) {|n| "department-#{n}" }
    users_count 0
  end
end
