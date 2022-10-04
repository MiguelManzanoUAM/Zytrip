class ChangeTripColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :city, :string
    remove_column :trips, :country, :string
    rename_column :trips, :description, :subtitle
    rename_column :trips, :body, :description
    add_column :trips, :duration, :string
  end
end
