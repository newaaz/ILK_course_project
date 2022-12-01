FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end

  factory :partner do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    before(:create) { |user| user.confirm }
  end
end
