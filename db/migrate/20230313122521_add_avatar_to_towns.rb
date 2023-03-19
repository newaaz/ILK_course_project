class AddAvatarToTowns < ActiveRecord::Migration[7.0]
  def change
    add_column :towns, :avatar, :string
    add_column :towns, :description, :string
  end
end
