require "open-uri"

# categories for properties
# Category.destroy_all
# Category.create(title: 'propertys', ordinal_number: 1)
# Category.create(title: 'Apartments', ordinal_number: 1)
# Category.create(title: 'Flat', ordinal_number: 1)

#Towns
# Town.destroy_all
# Town.create(name: 'Феодосия', parent_name: 'Феодосии', ordinal_number: 1,
#             description: "Это замечательный курортный город в Крыму, который неизменно пользуется популярностью у отдыхающих. Туристам и отдыхающим есть на что посмотреть - это и музеи, и живописные парки, и песчаные и галечные пляжи, и древние памятники архитектуры",
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_feo.jpg")))

# Town.create(name: 'Коктебель', parent_name: 'Коктебеле', ordinal_number: -2,
#             description: "В переводе это слово означает 'край голубых холмов'. Здесь жил и творил Волошин, здесь проходит Джаз-Фестиваль. Творческие натуры чувствуют себя здесь свободно и комфортно",
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_koktebel.jpg")))

# Town.create(name: 'Приморский', parent_name: 'Приморском', ordinal_number: 3,
#             description: "Расположен на берегу Феодосийского залива в 14 километрах от Феодосии. Жильё для отдыха в посёлке самое разнообразное. Именно поэтому этот небольшой посёлок часто выбирают для отдыха в Крыму люди с самым разным достатком. Есть школа виндсёрфинга",
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_primorskiy.jpg")))

# Town.create(name: 'Орджоникидзе', parent_name: 'Орджоникидзе', ordinal_number: -1,
#             description: "Посёлок расположен на берегу бухты, с трёх сторон омывается морем. Вокруг - горы, холмы и голубая бездна моря. Здесь очень чистая вода. Этот факт очень важен, так как в этот укромный уголок Крыма приезжают на отдых чаще всего родители с детьми. Цена на отдых в Орджоникидзе ниже, чем в соседних городах и посёлках",
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_orjo.jpg")))

# Town.create(name: 'Береговое', parent_name: 'Береговом', ordinal_number: 2,
#             description: "Это небольшой посёлок, рядом с Феодосией. Население здесь всего несколько тысяч, а ритм жизни - неторопливый и размеренный, как крымское лето",
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_beregovoe.jpg")))


# Create property
Property.destroy_all

geolocation = Geolocation.new(latitude: '45.05865', longitude:'35.39088')

property = Property.new(geolocation:  geolocation,
                        title:        "Hotel 'Odissey'",
                        address:      'Lenina 15',
                        town:         Town.first,
                        category:     Category.first,
                        owner:        Partner.first
                       )

avatar = File.open(File.join(Rails.root, "app/assets/images/seed/property/p (1).jpg"))
image1 = File.open(File.join(Rails.root, "app/assets/images/seed/property/p (2).jpg"))
image2 = File.open(File.join(Rails.root, "app/assets/images/seed/property/p (3).jpg"))

property.avatar.attach(io: avatar, filename: 'p(1).jpg')
property.images.attach(io: image1, filename: 'p(2).jpg')
property.images.attach(io: image2, filename: 'p(3).jpg')

property.save

# Create Room
room = property.rooms.build(title: 'Стандартный 2-х местный номер')
room.avatar.attach(io: File.open(File.join(Rails.root, "app/assets/images/seed/property/p (2).jpg")), filename: 'r(1).jpg')
room.images.attach(io: File.open(File.join(Rails.root, "app/assets/images/seed/property/p (1).jpg")), filename: 'r(2).jpg')
room.images.attach(io: File.open(File.join(Rails.root, "app/assets/images/seed/property/p (3).jpg")), filename: 'r(3).jpg')

room.save
