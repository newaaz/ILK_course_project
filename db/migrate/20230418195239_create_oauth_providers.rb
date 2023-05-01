class CreateOauthProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :oauth_providers do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps

      t.index [:provider, :uid], unique: true
    end
  end
end
