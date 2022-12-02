FactoryBot.define do
  factory :property do
    title { "Hotel 'Alexandra'" }
    address { 'Lenina 15' }
    owner { association :user }
    category
    town
  end
end
