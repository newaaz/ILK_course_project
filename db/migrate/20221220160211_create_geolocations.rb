class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.float :longitude, precision: 8, scale: 6
      t.float :latitude, precision: 8, scale: 6
      t.belongs_to :geolocable, polymorphic: true

      t.timestamps
    end

    add_index :geolocations, [:latitude, :longitude]
  end
end
