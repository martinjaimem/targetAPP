FactoryBot.define do
  factory :topic do
    label { Faker::Lorem.sentence }
  end
end
