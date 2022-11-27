class CreateTowns < ActiveRecord::Migration[7.0]
  def change
    create_table :towns do |t|
      t.string :name, null: false
      t.string :parent_name, null: false
      t.integer :number, default: 1, limit: 1, null: false

      t.timestamps
    end
  end
end
