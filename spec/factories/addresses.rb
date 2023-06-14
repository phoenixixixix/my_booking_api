FactoryBot.define do
  factory :address do
    country { Faker::Address.country }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    phone_number { "+8921341555" }
    property
  end
end
