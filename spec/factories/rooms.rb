FactoryBot.define do
  factory :room do
    title     { 'Standard 3-x' }
    property  { association :property }

    trait :invalid do
      title { nil }
    end
  end
end
