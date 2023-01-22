class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.float :longitude, precision: 7, scale: 5
      t.float :latitude, precision: 7, scale: 5
      t.belongs_to :geolocable, polymorphic: true

      t.timestamps
    end

    add_index :geolocations, [:latitude, :longitude]
  end
end
