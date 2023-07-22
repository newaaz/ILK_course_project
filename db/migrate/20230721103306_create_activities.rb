class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string  :title, null: false
      t.string  :category_title, null: false
      t.string  :listing_type, null: false
      t.text    :description, null: false
      t.text    :additional_info
      t.string :address
      t.integer :price
      t.string :price_type
      t.string :email
      t.string :site
      t.string :vk_group
      t.string :avatar
      t.json :images    

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
