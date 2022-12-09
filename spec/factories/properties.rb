FactoryBot.define do
  factory :property do
    title     { "Hotel 'Alexandra'" }
    address   { 'Lenina 15' }
    owner     { association :partner }
    category  { association :category }
    town      { association :town }

    trait :invalid do
      address { nil }
    end
  end
end
