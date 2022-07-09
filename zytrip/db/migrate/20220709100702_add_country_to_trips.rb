class AddCountryToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :country, :string
    add_column :trips, :city, :string
  end
end
