class AddImageToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :image, :string
  end
end
