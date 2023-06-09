class PropertyDetail < ApplicationRecord
  AMENITIES = {
                washer: 'Стиральная машинка',
                closed_yard: 'Закрытый двор', 
                terrace: 'Терраса',
                brazier: 'Мангал',
                printer: 'Принтер',
                notebok: 'Ноутбук'
              }.freeze

  belongs_to :property
end
