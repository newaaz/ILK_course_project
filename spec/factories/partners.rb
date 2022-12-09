FactoryBot.define do


  factory :partner do
    sequence(:email) { |n| "partner_#{n}@test.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    before(:create) { |user| user.confirm }
  end
end
