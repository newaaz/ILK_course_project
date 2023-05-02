FactoryBot.define do
  factory :oauth_provider do
    customer { nil }
    provider { "MyString" }
    uid { "MyString" }
  end
end
