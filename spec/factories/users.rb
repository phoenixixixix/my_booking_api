FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "welcome" }
    password_confirmation { |u| u.password }

    trait :member do
      type { "Member" }
    end

    trait :admin do
      type { "Admin" }
    end
  end
end
