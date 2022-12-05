class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :property, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :guest_base_count, limit: 1, null: false, default: 2
      t.integer :guest_max_count, limit:1, null: false, default: 4

      t.timestamps
    end
  end
end
