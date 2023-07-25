class CreateServicesTownsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :services, :towns do |t|
      t.index [:service_id, :town_id]
      t.index [:town_id, :service_id]
    end
  end
end
