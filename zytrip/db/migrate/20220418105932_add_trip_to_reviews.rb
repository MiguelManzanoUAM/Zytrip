class AddTripToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :trip, foreign_key: true
  end
end
