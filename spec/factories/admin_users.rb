$admin_user_password = Faker::Lorem.characters(10)

FactoryGirl.define do
  factory :admin_user do
    sequence(:email) {|n| "user-#{n}@hrmap.dev" }
    password $admin_user_password
    password_confirmation $admin_user_password
  end
end
