class AddOrganizerToTrips < ActiveRecord::Migration[7.0]
  def change
    add_reference :trips, :organizer, foreign_key: { to_table: :users }, null: false
  end
end
