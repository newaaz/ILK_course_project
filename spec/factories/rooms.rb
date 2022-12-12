FactoryBot.define do
  factory :room do
    title     { 'Standard 3-x' }
    property  { association :property }

    trait :invalid do
      title { nil }
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
  end
end
