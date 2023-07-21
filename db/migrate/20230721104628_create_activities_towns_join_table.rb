class CreateActivitiesTownsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :activities, :towns do |t|
      t.index [:activity_id, :town_id]
      t.index [:town_id, :activity_id]
    end
  end
end
