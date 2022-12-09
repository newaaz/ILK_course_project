# categories for properties
Category.destroy_all
Category.create(title: 'Hotels', ordinal_number: 1)
Category.create(title: 'Apartments', ordinal_number: 1)
Category.create(title: 'Flat', ordinal_number: 1)

#Towns
Town.destroy_all
Town.create(name: 'Феодосия', parent_name: 'Феодосии', ordinal_number: 1)
Town.create(name: 'Коктебель', parent_name: 'Коктебеле', ordinal_number: -2)
Town.create(name: 'Приморский', parent_name: 'Приморском', ordinal_number: 2)



