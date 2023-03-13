class AddAvatarToTowns < ActiveRecord::Migration[7.0]
  def change
    add_column :towns, :avatar, :string
  end
end
