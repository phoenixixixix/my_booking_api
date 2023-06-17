FactoryBot.define do
  factory :booking do
    user { nil }
    property { nil }
    from_date { "2023-06-17" }
    to_date { "2023-06-17" }
  end
end
