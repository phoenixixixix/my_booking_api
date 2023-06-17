FactoryBot.define do
  factory :authentication_token do
    token { "MyString" }
    expires_at { "2023-06-15 17:43:44" }
    association user, :member
  end
end
