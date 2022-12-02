FactoryBot.define do
  sequence :email do |n|
    "partner_#{n}@test.com"
  end

  factory :partner do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
