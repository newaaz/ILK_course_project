class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string  :title, null: false
      t.string  :address 

      t.decimal :longitude, precision: 6, scale: 4
      t.decimal :latitude, precision: 6, scale: 4  

      t.references :owner, null: false, foreign_key: { to_table: :partners }
      t.references :town, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
