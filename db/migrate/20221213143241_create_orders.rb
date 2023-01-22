class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :adults, limit:1
      t.integer :kids, limit:1
      t.integer :total_amount, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
