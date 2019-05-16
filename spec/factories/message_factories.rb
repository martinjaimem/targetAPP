FactoryBot.define do
  factory :message do
    text { Faker::Lorem.sentence }
    read { Faker::Boolean.boolean }
    user
    conversation
  end
end
