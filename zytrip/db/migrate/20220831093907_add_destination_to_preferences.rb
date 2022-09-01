class AddDestinationToPreferences < ActiveRecord::Migration[7.0]
  def change
    add_column :preferences, :destination, :integer, default: 0
  end
end
