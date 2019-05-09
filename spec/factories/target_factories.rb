FactoryBot.define do
  factory :target do
    title { Faker::Lorem.sentence }
    radius { Faker::Number.decimal(2, 3) }
    lat { Faker::Number.decimal(2, 3) }
    lng { Faker::Number.decimal(2, 3) }
    association :user, factory: :user, strategy: :build
    association :topic, factory: :topic, strategy: :build
  end
end
