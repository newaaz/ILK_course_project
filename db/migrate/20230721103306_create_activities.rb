class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string  :title, null: false
      
      t.string :avatar
      t.json :images

      t.string :address
      t.integer :price
      t.string :price_per

      t.integer :rating, limit: 2, default: 10      
      t.integer :random_id, limit: 2, default: 1    
      t.integer :promouted, limit: 2, default: 0

      t.boolean :activated, default: false
      t.boolean :deleted, default: false
      t.boolean :enabled, default: true
      t.boolean :blocked, default: false

      t.references :owner, null: false, foreign_key: { to_table: :partners }

      t.timestamps
    end
  end
end
