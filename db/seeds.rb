require "open-uri"

# categories for properties
# Category.destroy_all
# Category.create(title: 'Hotels', ordinal_number: 1)
# Category.create(title: 'Apartments', ordinal_number: 1)
# Category.create(title: 'Flat', ordinal_number: 1)

#Towns
# Town.destroy_all
# Town.create(name: 'Феодосия', parent_name: 'Феодосии', ordinal_number: 1,
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_feo.jpg")))
# Town.create(name: 'Коктебель', parent_name: 'Коктебеле', ordinal_number: -2,
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_koktebel.jpg")))
# Town.create(name: 'Приморский', parent_name: 'Приморском', ordinal_number: 3,
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_primorskiy.jpg")))
# Town.create(name: 'Орджоникидзе', parent_name: 'Орджоникидзе', ordinal_number: -1,
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_orjo.jpg")))
# Town.create(name: 'Береговое', parent_name: 'Береговом', ordinal_number: 2,
#             avatar: File.open(File.join(Rails.root, "app/assets/images/towns_avatars/avatar_beregovoe.jpg")))

geolocation = Geolocation.new
geolocation.latitude = '45.05865'
geolocation.longitude = '35.39088'

hotel = Property.new
hotel.geolocation = geolocation
hotel.title = "Hotel 'Alexandra11111'"
hotel.address = 'Lenina 15'
hotel.town = Town.first
hotel.category = Category.first
hotel.owner = Partner.first

avatar = URI.open('https://via.placeholder.com/150')

image1 = URI.open('https://via.placeholder.com/250')
image2 = URI.open('https://via.placeholder.com/250')

hotel.avatar.attach(io: avatar, filename: 'logo.png')

hotel.images.attach(io: image1, filename: 'image1.png')
hotel.images.attach(io: image2, filename: 'image2.png')

hotel.save


