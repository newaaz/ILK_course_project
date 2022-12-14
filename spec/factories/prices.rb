FactoryBot.define do
  factory :price do
    room  { association :room }
    start_date { "2022-05-01" }
    end_date { "2022-06-03" }
    day_cost { 60 }    
  end
end
