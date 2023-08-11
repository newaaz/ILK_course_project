class FoodPlace < ApplicationRecord
  FOOD_PLACE_TAGS = {
                      "0" => "Доставка еды и обедов",
                      "1" => "Вегетарианское меню",
                      "2" => "Гриль",
                      "3" => "Итальянская кухня",
                      "4" => "Французская кухня",
                      "5" => "Веганское меню",
                      "6" => "Парковка",
                      "7" => "Спортивные трансляции",
                      "8" => "Летняя веранда",
                      "9" => "Детская комната",
                      "10" => "Морепродукты",
                      "11" => "Кофейня",
                      "12" => "Пиццерия",
                      "13" => "Суши",
                      "14" => "Шашлычная",
                      "15" => "Бар, паб",
                      "16" => "Кальяны",
                      "17" => "Китайская кухня",
                      "18" => "Индийская кухня",
                      "19" => "Пекарня",
                      "20" => "Стейкхаус",
                      "21" => "Быстрое питание",
                      "22" => "Уличная еда",
                      "23" => "Десерты"
                    }.freeze
  

  belongs_to :owner, class_name: 'Partner'
  belongs_to :town

  include CarrierwaveImagable
  include Geolocable
  include ListingActivatable
  include Contactable
  include AdditionalFieldable
  include Favoritable
  include Ratingable

  validates :title, :description, :town_id, presence: true
end
