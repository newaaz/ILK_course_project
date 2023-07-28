class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string  :title, null: false
      t.string  :category_title, null: false
      t.text    :description, null: false
      t.string  :address
      t.text    :how_to_get
      t.string  :email
      t.string  :site
      t.string  :vk_group
      t.string  :avatar
      t.json    :images    

      t.integer :rating, limit: 2, default: 10      
      t.integer :random_id, limit: 2, default: 1    
      t.integer :promouted, limit: 2, default: 0

      t.boolean :activated, default: false
      t.boolean :deleted, default: false
      t.boolean :enabled, default: true
      t.boolean :blocked, default: false

      t.references :owner, null: false, foreign_key: { to_table: :partners }
      t.references :town, null: false, foreign_key: true

      t.timestamps
    end
  end
end
