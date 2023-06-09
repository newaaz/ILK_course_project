class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :property, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :guest_base_count, limit: 1, null: false
      t.integer :guest_max_count, limit:1, null: false

      t.string  :description
      t.integer :serial_number, limit:1, default: 1
      t.integer :room_count, limit:1, default: 1
      t.integer :size, limit:2
      t.string  :services, array: true, default: []
      t.string  :bathroom
      t.string  :beds
      t.string  :furniture
      t.string  :in_room      

      t.timestamps
    end
  end
end
