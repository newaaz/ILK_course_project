class CreatePropertyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :property_details do |t|
      t.references :property, null: false, foreign_key: true

      t.text    :short_description

      t.string  :food
      t.string  :parking
      t.string  :territory
      t.string  :transfer
      t.string  :amenities
      t.string  :additional_info

      t.string  :site
      t.string  :email
      t.string  :vk_group

      t.timestamps
    end
  end
end
