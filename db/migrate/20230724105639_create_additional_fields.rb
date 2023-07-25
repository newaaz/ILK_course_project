class CreateAdditionalFields < ActiveRecord::Migration[7.0]
  def change
    create_table :additional_fields do |t|
      t.string :name
      t.text :value
      t.references :additional_fieldable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
