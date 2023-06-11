class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :avatar
      t.string :messengers, array: true, default: []
      t.references :contactable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
