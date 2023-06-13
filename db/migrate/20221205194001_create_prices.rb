class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :room, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :day_cost
      t.integer :add_guest_cost

      t.timestamps
    end
  end
end
