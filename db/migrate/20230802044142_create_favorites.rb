class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.integer :items_count, default: 0
      t.timestamps
    end
  end
end
