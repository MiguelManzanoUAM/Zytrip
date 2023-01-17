class ChangeRatingsTypes < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :rating, :integer
    change_column :trips, :rating, :integer
  end
end
