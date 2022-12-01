class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(user_id: current_user.id, trip_id: params[:trip_id], rating: params[:rating].to_i, comment: params[:comment])
    trip = Trip.find_by(id: params[:trip_id])

    if !@review.save
      if (params[:rating].nil? || params[:rating].empty?)
        flash[:review_error] = "Introduce una valoración entre 0 y 5"
      elsif !((0..5).include? params[:rating].to_i)
        flash[:rating] = "Introduce una valoración entre 0 y 5"
      elsif params[:comment].length > 150
        flash[:review_error] = "descripción demasiado extensa (máximo 150 caracteres)"
      end

      redirect_to trip, flash: {notice: "¡Algo salió mal en tu valoración, vuelve a intentarlo!"}
    else
      Review.add_user_to_trip(@review)
      redirect_to trips_path
    end
  end

  private
  
  def review_params
    params.require(:review).permit(:rating, :trip_id, :comment)
  end
end
