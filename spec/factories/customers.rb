FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "customer_#{n}@test.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    before(:create) { |user| user.skip_confirmation! }
  end
end
