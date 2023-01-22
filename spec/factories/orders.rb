FactoryBot.define do
  factory :order do
    customer  { association :customer }
    property  { association :property }
    room      { association :room }
    check_in  { "2022-06-05" }
    check_out { "2022-07-09" }    

    trait :invalid do
      check_in  { nil }
      check_out { nil }
    end

    to_create {|instance| instance.save(validate: false) }
  end
end
