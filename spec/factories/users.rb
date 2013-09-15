$user_password = Faker::Lorem.characters(10)

FactoryGirl.define do
  factory :user do
    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    sequence(:email)      {|n| "user-#{n}@hrmap.dev" }
    password              $user_password
    password_confirmation $user_password
    city                  Faker::Address.city
    state                 Faker::Address.state
    job                   Faker::Lorem.sentence(4)
    category              Faker::Lorem.words(10).sample
    phone                 Faker::PhoneNumber.phone_number
    cv                    File.new(File.join(Rails.root, 'spec', 'support', 'assets', 'cv.pdf'))
    avatar                File.new(File.join(Rails.root, 'spec', 'support', 'assets', 'avatar.png'))
    employment_date       [Time.now, Time.now - 2 * 24 * 3600, Time.now - 35 * 24 * 3600].sample
  end
end
