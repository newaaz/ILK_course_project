class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :property, null: false, foreign_key: true
      t.integer :guest_id, null: false, foreign_key: true
      t.integer :room_id      

      t.date :check_in
      t.date :check_out

      t.string :guest_name
      t.string :guest_email
      t.string :guest_phone
      t.string :wishes

      t.integer :adults, limit:1
      t.integer :kids, limit:1
      t.integer :total_amount, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
