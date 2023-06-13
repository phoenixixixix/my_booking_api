FactoryBot.define do
  factory :property do
    title { Faker::Address.community }
    placement_type { "hotel" }
  end
end
