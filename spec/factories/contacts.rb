FactoryBot.define do
  factory :contact do
    name { "MyString" }
    phone_number { "MyString" }
    avatar { "MyString" }
    messengers { "MyText" }
    contactable { nil }
  end
end
