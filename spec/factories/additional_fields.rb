FactoryBot.define do
  factory :additional_field do
    name { "MyString" }
    value { "MyText" }
    fieldable { nil }
  end
end
