class AddAgencyToTrips < ActiveRecord::Migration[7.0]
  def change
    add_reference :trips, :agency, foreign_key: true
  end
end
