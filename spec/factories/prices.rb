FactoryBot.define do
  factory :price do
    room  { association :room }
    start_date { "2022-12-05" }
    end_date { "2022-12-05" }
    day_cost { 60 }    
  end
end
