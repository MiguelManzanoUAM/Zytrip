class CreateJoinTableTripUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Trips, :Users do |t|
      t.index [:trip_id, :user_id]
      t.index [:user_id, :trip_id]
    end
  end
end
