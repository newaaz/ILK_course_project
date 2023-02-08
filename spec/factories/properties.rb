FactoryBot.define do
  factory :property do
    title     { "Hotel 'Alexandra'" }
    address   { 'Lenina 15' }
    owner     { association :partner }
    category  { association :category }
    town      { association :town }

    before(:create) { |property| create(:geolocation, geolocable: property) }

    trait :invalid do
      address { nil }
    end

    trait :imagable do  
      after(:build) do |model_self|
        model_self.avatar.attach(
          io: File.open(Rails.root.join('spec', 'support', 'assets', 'placeholder10.jpg')),
          filename: 'placeholder10.jpg',
          content_type: 'image/jpeg'
        )
        model_self.images.attach([
          io: File.open(Rails.root.join('spec', 'support', 'assets', 'placeholder20.jpg')),
          filename: 'placeholder20.jpg',
          content_type: 'image/jpeg',
          io: File.open(Rails.root.join('spec', 'support', 'assets', 'placeholder30.jpg')),
          filename: 'placeholder30.jpg',
          content_type: 'image/jpeg'
        ])
      end
    end

    trait :reindex do
      after(:create) do |property, _evaluator|
        property.reindex(refresh: true)
      end
    end
  end
end
