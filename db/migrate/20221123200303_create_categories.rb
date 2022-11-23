class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.integer :number, null: false, default: 1, limit: 1
    end
  end
end
