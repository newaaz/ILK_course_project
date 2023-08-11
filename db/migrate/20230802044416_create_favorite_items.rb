class CreateFavoriteItems < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_items do |t|
      t.references :favorite, null: false, foreign_key: true
      t.references :listing, polymorphic: true, null: false
    end
  end
end
