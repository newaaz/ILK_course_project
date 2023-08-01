PROPERTY_TITLES = ["Гостевой дом 'Одиссей'", "Гостевой дом 'Александра'", "Гостиница 'Орхидея'",
                  "Апартаменты 'Парус'", "Эллинг 'Катран'", "Дом под ключ в центре",
                  "3-х комнатная квартира у моря", "Гостиница У Моря", "Эко гостевой дом 'Здоровье'",
                  "Отель 'Бриз'", "Апартаменты 'Хижина Робинзона'", "Вилла 'Santa Fe'", "Апартаменты 'На Черноморской'"].freeze

ADRESSES = ["ул. Ленина 15", "Черноморская набережная, д. 1В", "ул. Бусина 35", "ул. Приморская 65 B",
                     "переулок Лазурный, д.7", "ул. Луначарского, д. 16", "Севастопольское шоссе, д. 22", "ул. Ленина, 35 б",
                     "эллинг 60"].freeze

ACTIVITY_TITLES = ["Прогулка на каяках у Кара Дага", "Прыжок с парашютом в тандеме", "Конная прогулка к подножию Эчки Дага", "Дайвинг в Береговом",
                   "Джипинг", "Виндсерфинг в Приморском", "Прогулка на воздушном шаре", "Экскурсия на джипе по горам Феодосии", "Конные прогулки - сердце генценберга",
                    "Воздушные прогулки", "Морские прогулки", "Конные прогулки - Тепе-Оба", "Прогулки на квадроциклах"].freeze

SERVICE_TITLES = ["Такси 'Девяточка'", "Служба такси 'Виктор'", "Детсая комната 'Одуванчик'", "Ремонт обуви", "Ремонт смартфонов",
                   "Спортзал 'Аполлон'", "Маникюр/педикюр", "Массаж", "Доставка еды 'БыстроПицца'", "Прокат авто", "Услуги эваукатора",
                   "Бильярд 'Кий'", "Теннис", "Сауна, русские и турецкие бани ", "Салон красоты 'Loris'"]

PLACE_TITLES = ["Золотой песок", "Солнечный залив", "Бриз моря", "Исторический замок", "Видовая площадка", "Памятник Свободы",
                  "Цветущий сад", "Центральный парк", "Озерная роща", "Звездный экран", "Арт-хаус", "Мегаплекс",
                  "Музей изобразительных искусств", "Музей истории", "Научный музей", "Драматический театр", "Оперный театр",
                  "Кабаре-театр", "Центральный рынок", "Фермерский рынок", "Антикварный базар", "Аллея цветов", "Старый город",
                  "Граффити-стена", "Футбольное поле", "Теннисные корты", "Скейтпарк", "Кулинарный фестиваль", "Музыкальный концерт",
                  "Выставка современного искусства"]

FOOD_PLACE_TITLES = ["Вкусная точка", "Гурманово местечко", "Лакомое место", "Уютный уголок", "Сытный перекус",
                      "Свежие вкусности", "Голодный Мишка", "Вкусная феерия", "Палатка вкусностей", "Традиции и вкус",
                      "Рай для гурманов", "Ярмарка вкусов", "Столовая радость", "Кафешенька 'Смак'", "Вкусные истории",
                      "Ресторан 'Вкусов'", "Гастрономическое путешествие", "Память о вкусе", "Большой аппетит", "Кулинарное наслаждение",
                      "Сытый охотник", "Food Heaven", "Творческая кухня", "Кафе 'Шедевр'", "Гастрономическая фантазия", "Столовая река",
                      "Вкусненький край", "Шедевры кулинарии", "Гастро-магия", "кафе Вкусота", "кафе Гастро", "кафе Лакомство", "кафе Сытость",
                      "Аппетит", "Столовая 'На Динамо'", "кафе Суши", "пиццерия ПиццаПапа", "БургерКвин", "Десерты и сладости", "Чайный домик"]

# Categories for properties
def create_categories
  Category.destroy_all
  Category.create!([
    { title: 'Гостевые дома', ordinal_number: 1 },
    { title: 'Гостиницы', ordinal_number: 2 },
    { title: 'Квартиры', ordinal_number: 3 },
    { title: 'Частный сектор', ordinal_number: 4 },
    { title: 'Дома под ключ', ordinal_number: 5 },
    { title: 'Эллинги', ordinal_number: 6 },
    { title: 'Пансионаты', ordinal_number: 7 },
    { title: 'Бюджетное жильё', ordinal_number: 8 },
    { title: 'Другое', ordinal_number: 9}
  ])
  puts "Categories created"
end

# Towns
def create_towns
  Town.destroy_all
  Town.create!([
    {
      name: 'Феодосия', parent_name: 'Феодосии', ordinal_number: 1,
      description: "Это замечательный курортный город в Крыму, который неизменно пользуется популярностью у отдыхающих. Туристам и отдыхающим есть на что посмотреть - это и музеи, и живописные парки, и песчаные и галечные пляжи, и древние памятники архитектуры",
      avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_feo.jpg"))
    },
    {
      name: 'Коктебель', parent_name: 'Коктебеле', ordinal_number: -2,
      description: "В переводе это слово означает 'край голубых холмов'. Здесь жил и творил Волошин, здесь проходят фестивали джазовой музыки. Творческие натуры чувствуют себя здесь свободно и комфортно",
      avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_koktebel.jpg"))
    },
    {
      name: 'Приморский', parent_name: 'Приморском', ordinal_number: 3,
      description: "Расположен на берегу Феодосийского залива в 14 километрах от Феодосии. Жильё для отдыха в посёлке самое разнообразное. Именно поэтому этот небольшой посёлок часто выбирают для отдыха в Крыму люди с самым разным достатком. Есть школа виндсёрфинга",
      avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_primorskiy.jpg"))
    },
    {
      name: 'Орджоникидзе', parent_name: 'Орджоникидзе', ordinal_number: -1,
      description: "Посёлок расположен на берегу бухты, с трёх сторон омывается морем. Вокруг - горы, холмы и голубая бездна моря. Здесь очень чистая вода. Этот факт очень важен, так как в этот укромный уголок Крыма приезжают на отдых чаще всего родители с детьми. Цена на отдых в Орджоникидзе ниже, чем в соседних городах и посёлках",
      avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_orjo.jpg"))
    },
    {
      name: 'Береговое', parent_name: 'Береговом', ordinal_number: 2,
      description: "Это небольшой посёлок, рядом с Феодосией. Население здесь всего несколько тысяч, а ритм жизни - неторопливый и размеренный, как крымское лето",
      avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_beregovoe.jpg"))
    }
  ])
  puts "Towns created"
end

def rand_image_path  
  Pathname.new(Rails.root.join("app/assets/images/seed/property/p (#{rand 1..15}).jpg"))
end

def rand_price
  (rand(1000..2500) / 50).round * 50
end

# create place
def create_food_place
  food_place = FoodPlace.create!(title:          FOOD_PLACE_TITLES.sample,
                        tags: [1,2,3,4,5,6,7,8,9,10,11],
                        avatar:         File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg")),
                        images:         [ 
                                          File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/food_places/food_place (#{rand 1..15}).jpg"))
                                        ],
                        address:        ADRESSES.sample,
                        description:    "ЭТОТ ОБЪЕКТ ПРЕДНАЗНАЧЕН ДЛЯ ДЕМОНСТРАЦИИ РАБОТЫ ПРИЛОЖЕНИЯ. ФОТОГРАФИИ, ИНФОРМАЦИЯ И КОНТАКТЫ ЯВЛЯЮТСЯ ПРИМЕРОМ. ЗАБРОНИРОВАТЬ В РЕАЛЬНОСТИ ЭТОТ ОБЪЕКТ НЕЛЬЗЯ.
                                        Названия придумывал ChatGPT.
                                        Уютное и комфортное кафе, где тёплые тона в интерьере и мягкий свет создают обволакивающую атмосферу, которая снимает напряжение. 
                                        Кафе подойдет для деловой встречи, для свидания под романтическую музыку, для прекрасного ужина за бокалом вина в кругу друзей или семьи. Также здесь предлагаются все условия для проведения свадеб, банкетов и корпоративных мероприятий.
                                        В кафе гостей ждут не только сезонные обновления меню, но и множество других событий: регулярные выставки, живые концерты, выступления лучших диджеев и многое другое.
                                        Концептуальная идея смешения западных и восточных традиций нашла отражение и в меню ресторана, построенном на гармоничном соседстве европейской и восточной гастрономии.
                                        С приходом теплых дней часть веселья переносится на летнюю веранду – уютный красивый дворик с видом на город. Высококлассное обслуживание, доброжелательный персонал, качественная кухня с авторской «изюминкой», и правильная музыка позволяют нам надеяться, что, побывав здесь однажды, Вы будете возвращаться вновь.",
                        menu:           "Меню: В меню представлены хиты различных кухонь мира: традиционная европейская, армянская, авторская кухня. Здесь можно пообедать с деловым партнером, поужинать в кругу друзей и семьи или отметить значимую дату. Живая музыка, вкусные блюда, вежливый персонал – эти и другие моменты говорят сами за себя.",
                        activated:    true,
                        site:         'ilovekrim.ru',
                        email:        'email@email.ru',
                        vk_group:     'i_lovekrim',
                        owner:        Partner.first,
                        town:         Town.all.sample,
                        geolocation:  Geolocation.new(
                          latitude: "45.0#{rand 60..80}65",
                          longitude: "35.3#{rand 60..80}88"),
                        contact:      Contact.new(
                          phone_number: '+7(987)123-45-67',                      
                          name:         'Администратор',
                          messengers:   ["whatsapp", "viber", "telegram"]))
                          
  food_place.additional_fields.create!([{ name: 'Доставка', value: 'Есть. Смотрите на сайте' },
                                        { name: 'Режим работы', value: 'с 8-00 до 23-00' },
                                        { name: 'Живая музыка', value: 'Есть' },
                                        { name: 'Парковка', value: 'Есть' } ])  
  puts "Food place #{food_place.title} created"                    
end

# create place
def create_place
  place = Place.create!(title:          PLACE_TITLES.sample,
                        category_title: Place::PLACE_CATEGORIES.sample,
                        avatar:         File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg")),
                        images:         [ 
                                          File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/places/place (#{rand 1..32}).jpg"))
                                        ],
                        address:        ADRESSES.sample,
                        description:    "ЭТОТ ОБЪЕКТ ПРЕДНАЗНАЧЕН ДЛЯ ДЕМОНСТРАЦИИ РАБОТЫ ПРИЛОЖЕНИЯ. ФОТОГРАФИИ, ИНФОРМАЦИЯ И КОНТАКТЫ ЯВЛЯЮТСЯ ПРИМЕРОМ. ЗАБРОНИРОВАТЬ В РЕАЛЬНОСТИ ЭТОТ ОБЪЕКТ НЕЛЬЗЯ.
                                        Названия придумывал ChatGPT.
                                        В океанариуме вы познакомитесь с грозными пираньями, рифовыми акулами, рыбами Красного моря и озёр Африки.
                                        У нас вы сможете полюбоваться на пингвинов-одних из самых забавнейших жителей нашей планеты. Веселая восьмерка Гумбольдта или, как их ещё называют, перуанских пингвинов, уже облюбовала место в солнечной Анапе. Поспешите познакомиться со всеми нашими обитателями.
                                        В нашем морском театре перед вами выступят звезды морского мира, чилийский морской лев, моржиха, северные морские котики, белый полярный кит и самые умные представители морских млекопитающих Тихоокеанские дельфины афалины.
                                        А после представления у вас будет возможность пообщаться с артистами поближе, сфотографироваться и даже поплавать, а самые любопытные смогут погрузиться с аквалангом в мир морских млекопитающих.
                                        Для того чтоб память о нашем дельфинарии осталась в ваших сердцах надолго после представления вы сможете приобрести сувенир на память, DVD диск где мы записали все, что попало к Вам на глаза в нашем комплексе.",
                        activated:    true,
                        site:         'ilovekrim.ru',
                        email:        'email@email.ru',
                        vk_group:     'i_lovekrim',
                        owner:        Partner.first,
                        town:         Town.all.sample,
                        geolocation:  Geolocation.new(
                          latitude: "45.0#{rand 60..80}65",
                          longitude: "35.3#{rand 60..80}88"),
                        contact:      Contact.new(
                          phone_number: '+7(987)123-45-67',                      
                          name:         'Алла',
                          messengers:   ["whatsapp", "viber", "telegram"]))
                          
  place.additional_fields.create!([ { name: 'Что взять с собой', value: 'Солнцезащитный крем, очки, вода, головной убор' },
                                    { name: 'Длительность', value: '2 часа' },
                                    { name: 'Включено', value: 'Сопровождение инструктора, опытная команда' },
                                    { name: 'Маршрут', value: 'Феодосия - Орджоникидзе - Коктебель' } ])  
  puts "place #{place.title} created"                    
end

# create Service
def create_service
  service = Service.create!(title:          SERVICE_TITLES.sample,
                            category_title: Service::SERVICE_CATEGORIES.sample,
                            avatar:         File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg")),
                            images:         [ 
                                              File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg")),
                                              File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg")),
                                              File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg")),
                                              File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg")),
                                              File.open(File.join(Rails.root, "app/assets/images/seed/services/service (#{rand 1..25}).jpg"))
                                            ],
                            address:        ADRESSES.sample,
                            #price:          rand_price,
                            #price_type:     "За прогулку",
                            description:    "ЭТОТ ОБЪЕКТ ПРЕДНАЗНАЧЕН ДЛЯ ДЕМОНСТРАЦИИ РАБОТЫ ПРИЛОЖЕНИЯ. ФОТОГРАФИИ, ИНФОРМАЦИЯ И КОНТАКТЫ ЯВЛЯЮТСЯ ПРИМЕРОМ. ЗАБРОНИРОВАТЬ В РЕАЛЬНОСТИ ЭТОТ ОБЪЕКТ НЕЛЬЗЯ.
                            Ногтевая студия предлагает услуги маникюра и педикюра. Покрытие гель лаком. Различные виды дизайнов. Наращивание ногтей. Качественные материалы и новое оборудование. Все инструменты проходят все стадии стерилизации. Более 400 оттенков гель лаков! Много новинок. Частое обновление палитры.
                            Накопительная система бонусов, за каждый визит на личный счёт поступают бонусы, которыми можно оплатить услуги. Таким образом вы всегда получаете скидку, обслуживаясь у нас! Запись по телефону, также ватсап. Очень удобно записываться самостоятельно по онлайн ссылке, она есть в любом поисковике.",
                            additional_info: "У нас просторная студия, маникюрный зал отделен от педикюрного, для удобства и комфорта клиентов и мастеров.
                                              Работают 3 топ мастера, старший мастер и мастер, поэтому всегда можно подобрать удобное для вас время. Учитывайте, что у каждого мастера свой стаж и время работы, поэтому стоимость услуг у всех отличается. Также услуги бровиста! В студии работает косметолог.",
                            activated:    true,
                            site:         'ilovekrim.ru',
                            email:        'email@email.ru',
                            vk_group:     'i_lovekrim',
                            owner:        Partner.first,
                            town_ids:     Town.ids,
                            geolocation:  Geolocation.new(
                              latitude: "45.0#{rand 60..80}65",
                              longitude: "35.3#{rand 60..80}88"),
                            contact:      Contact.new(
                              phone_number: '+7(987)123-45-67',                      
                              name:         'Алла',
                              messengers:   ["whatsapp", "viber", "telegram"]))        

  service.additional_fields.create!([{ name: 'Маникюр с покрытием гель-лаком (1 ч 30 мин.)', value: 'от 1 000 ₽' },
                                     { name: 'Наращивание ногтей (2 ч)', value: 'от 1 400 ₽' },
                                     { name: 'Комбинированный маникюр (45 мин.)', value: 'от 500 ₽' },
                                     { name: 'Покрытие с градиентом (омбре) (30 мин.)', value: 'от 200' }])
  
  puts "service #{service.title} created"
end

# create actitvity
def create_activity
  actitvity = Activity.create!( title:          ACTIVITY_TITLES.sample,
                                category_title: Activity::ACTIVITY_CATEGORIES.sample,
                                avatar:         File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg")),
                                images:         [ 
                                                  File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg")),
                                                  File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg")),
                                                  File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg")),
                                                  File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg")),
                                                  File.open(File.join(Rails.root, "app/assets/images/seed/activities/activity (#{rand 1..20}).jpg"))
                                                ],
                                address:        ADRESSES.sample,
                                price:          rand_price,
                                price_type:     "За прогулку",
                                description:    "ЭТОТ ОБЪЕКТ ПРЕДНАЗНАЧЕН ДЛЯ ДЕМОНСТРАЦИИ РАБОТЫ ПРИЛОЖЕНИЯ. ФОТОГРАФИИ, ИНФОРМАЦИЯ И КОНТАКТЫ ЯВЛЯЮТСЯ ПРИМЕРОМ. ЗАБРОНИРОВАТЬ В РЕАЛЬНОСТИ ЭТОТ ОБЪЕКТ НЕЛЬЗЯ. Готовься к незабываемому приключению наших морских прогулок! С брызгами океанской волны, свежим морским воздухом и захватывающими видами мы предлагаем заставить ваше сердце забиться быстрее.
                                                Присоединяйтесь к нам в увлекательных прогулках по побережью! Наша команда экспертов с легкостью проведет вас через изумрудные воды и прекрасные морские пейзажи, раскрывая перед вами уникальные места и секретные пещеры, доступные только с морской стороны.
                                                Вы сможете почувствовать свободу, когда ветер сопротивляется вашим волосам, а солнечные лучи ласкают вашу кожу. Наша команда специализируется на создании неповторимых и запоминающихся моментов, поэтому вы сможете наслаждаться прогулкой, зная, что о вас позаботятся и создадут неповторимую атмосферу безопасности и комфорта.
                                                Мы предлагаем разные варианты морских прогулок, от романтических наблюдений заката до экстремальных морских приключений, таких как вейкбординг или подводное плавание с аквалангом. У нас есть опции для всех – от любителей спокойного отдыха до искателей адреналина!",
                                additional_info: "Бесподобные виды и впечатления: Морская прогулка позволяет насладиться удивительными видами природы, наблюдать диких животных и различные морские развлечения. Открывайте новые горизонты, фотографируйте красивые пейзажи и создавайте воспоминания, которые будут с вами навсегда.
                                                  Не забудьте, что предварительное бронирование обязательно, чтобы убедиться в наличии свободных мест и подготовке к вашему приходу.
                                                  Желаем вам незабываемых морских прогулок и великолепного отдыха на нашем сказочном побережье!",
                                activated:    true,
                                site:         'ilovekrim.ru',
                                email:        'email@email.ru',
                                vk_group:     'i_lovekrim',
                                owner:        Partner.first,
                                town_ids:     Town.ids,
                                geolocation:  Geolocation.new(
                                  latitude: "45.0#{rand 60..80}65",
                                  longitude: "35.3#{rand 60..80}88"),
                                contact:      Contact.new(
                                  phone_number: '+7(987)123-45-67',                      
                                  name:         'Геннадий',
                                  messengers:   ["whatsapp", "viber", "telegram"]))         

  actitvity.additional_fields.create!([{ name: 'Что взять с собой', value: 'Солнцезащитный крем, очки, вода, головной убор' },
                                       { name: 'Длительность', value: '2 часа' },
                                       { name: 'Включено', value: 'Сопровождение инструктора, опытная команда' },
                                       { name: 'Маршрут', value: 'Феодосия - Орджоникидзе - Коктебель' }])
  
  puts "Activity #{actitvity.title} created"
end

# Create property
def create_property
  property = Property.new(title:      PROPERTY_TITLES.sample,
                          avatar:     File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                          images:     [ 
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                        File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg"))
                                      ],
                          address:    ADRESSES.sample,
                          town:       Town.all.sample,
                          category:   Category.all.sample,
                          owner:      Partner.first,
                          activated:  true,
                          price_from: (rand(1000..5000) / 50).round * 50,
                          distance_to_sea: (rand(200..1500) / 50).round * 50,
                          services: ["kitchen", "excursions", "pool", "parking", "playground"],
                          geolocation:  Geolocation.new(
                            latitude: "45.0#{rand 60..80}65",
                            longitude: "35.3#{rand 60..80}88"),
                          contact:      Contact.new(
                            phone_number: '+7(987)123-45-67',                      
                            name: 'Мария Ивановна',
                            messengers: ["whatsapp", "viber", "telegram"]),
                          property_detail: PropertyDetail.new(
                            short_description: "ЭТОТ ОБЪЕКТ ПРЕДНАЗНАЧЕН ДЛЯ ДЕМОНСТРАЦИИ РАБОТЫ ПРИЛОЖЕНИЯ. ФОТОГРАФИИ, ИНФОРМАЦИЯ И КОНТАКТЫ ЯВЛЯЮТСЯ ПРИМЕРОМ. ЗАБРОНИРОВАТЬ В РЕАЛЬНОСТИ ЭТОТ ОБЪЕКТ НЕЛЬЗЯ. Гостиница находится в одном из лучших районов города. До моря идти 7-10 минут неспешным шагом, направится можно на два разных пляжа. Первый пляж 'Динамо' - песчанный с ровным песчанным дном. Второй из мелкой перетёртой ракушки - пляж санатория Восход. Вход на все пляжи Феодосии бесплатный. В гостинице сдаются 2-х, 3-х и 4-х местные номера класса Люкс. В номерах имеется всё что нужно для комфортного отдыха в Феодосии. А именно: кровати, телевизор, кондиционер, шкаф, сан.узел, кухонка с микроволновой печью, холодильником, раковиной, посудой и кухонной мебелью. Во дворе гостиницы бассейн, декоративный водоём с рыбками, цветы, ландшафтный дизайн, декоративные растения, беседка, виноградник - очень красиво. У номеров на втором этаже есть общий балкон со столиками у номеров.",
                            food: 'оборудованная кухня, возможность готовить еду самостоятельно 2 кухни',
                            parking: 'бесплатная, на территории',
                            territory: 'закрытый двор терраса, место для отдыха мангал, место для барбекю',
                            transfer: 'трансфер из аэропорта в Симферополе 2500 руб',
                            amenities: ["washer", "closed_yard", "terrace", "brazier", "printer", "notebok"],
                            additional_info: 'Услуги за отдельную плату: пользование стиральной машиной. Примечание: если клиент отказывается от бронирования, предоплата не возвращается.',
                            site: 'ilovekrim.ru',
                            email: 'email@email.ru',
                            vk_group: 'i_lovekrim'))
  
  # add images by ActiveStorage (deprecated)
  # property.avatar.attach(io: rand_image_path .open, filename: "avatar.jpg")
  # 6.times do |i|
  #   property.images.attach(io: rand_image_path .open, filename: "p_#{i + 1}.jpg")
  # end    
  
  # Create Room's
  4.times do |i|
    room = property.rooms.build(title: "Стандартный #{i + 1}-х местный номер",
                                avatar: File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                images: [ 
                                          File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg")),
                                          File.open(File.join(Rails.root, "app/assets/images/seed/property/p (#{rand 1..15}).jpg"))
                                        ],
                                guest_base_count: 2,
                                guest_max_count: rand(1..10),
                                rooms_count: 1,
                                size:   rand(20..50),
                                description: "Номера «люкс» подойдут для размещения четырех человек – отличный вариант для большой семьи",
                                services: ["sea_view", "mountain_view", "balcony", "tv", "satellite"],
                                bathroom: "Туалет и душ в номере, санузел совмещенный",
                                beds: "2 кровати",
                                furniture: "шкаф тумбочки",
                                in_room: "полный комплект посуды, посудомоечная машина, стиральная машина-автомат",
                                prices: [                                  
                                  Price.new(start_date: '01/03/2023', end_date: '31/03/2023', day_cost: rand_price),
                                  Price.new(start_date: '01/04/2023', end_date: '30/04/2023', day_cost: rand_price),
                                  Price.new(start_date: '01/05/2023', end_date: '31/05/2023', day_cost: rand_price),
                                  Price.new(start_date: '01/06/2023', end_date: '30/09/2025', day_cost: rand_price),
                                ])
    # add images by ActiveStorage (deprecated)
    # room.avatar.attach(io: rand_image_path .open, filename: "r(#{i}).jpg")
    # 5.times do |i|
    #   room.images.attach(io: rand_image_path .open, filename: "r_#{i + 1}.jpg")
    # end

    #puts "Room #{room.title} for #{room.property.title} created"
  end  

  property.save!
  #puts "Rooms = #{property.rooms.count}"
  puts "Property #{property.title} created"
end



time = Benchmark.measure do
  #create_categories
  #create_towns

  Property.destroy_all
  45.times { create_property }
  
  Activity.destroy_all
  25.times { create_activity }

  Service.destroy_all
  25.times { create_service }

  Place.destroy_all
  35.times { create_place }

  FoodPlace.destroy_all
  35.times { create_food_place }

  # Property.reindex
  # puts "Properties indexed"
end

puts "Время выполнения: #{time.real} секунд"
