class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(user_id: current_user.id, trip_id: params[:trip_id], rating: params[:rating], comment: params[:comment])
    @review.save
    Review.add_user_to_trip(@review)
    redirect_to trips_path
  end

  private
  
  def review_params
    params.require(:review).permit(:rating, :trip_id, :comment)
  end
end
