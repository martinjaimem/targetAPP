# This will guess the User class
FactoryBot.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    username { Faker::Internet.unique.user_name }
    gender   { rand(0..2) }
    push_token { Faker::Internet.password(10) }
  end
end
