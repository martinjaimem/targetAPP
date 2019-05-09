FactoryBot.define do
  factory :admin_user do
    email    { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
  end
end
