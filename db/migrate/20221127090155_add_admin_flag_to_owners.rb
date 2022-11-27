class AddAdminFlagToOwners < ActiveRecord::Migration[7.0]
  def change
    add_column  :owners, :admin, :boolean, null: false, default: false
  end
end
