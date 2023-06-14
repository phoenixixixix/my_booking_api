FactoryBot.define do
  factory :asset do
    title { Faker::House.furniture }
  end
end
