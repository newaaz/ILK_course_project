class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :property, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :room_id
      t.integer :adults, limit:1
      t.integer :kids, limit:1
      t.boolean :reservation_confirmed, default: false
      t.boolean :payment_successful, default: false
      t.string :owner_comment
      t.integer :total_amount
      t.text :wishes_comment
      t.string :customer_name
      t.string :customer_phone_number

      t.timestamps
    end
  end
end
