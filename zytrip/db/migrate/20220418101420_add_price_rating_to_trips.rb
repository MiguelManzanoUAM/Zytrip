class AddPriceRatingToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :price, :decimal, :default => 0.0
    add_column :trips, :rating, :decimal, :default => 0.0
  end
end
