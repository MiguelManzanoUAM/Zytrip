class Admin::ReviewsController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @reviews = Review.all

    respond_to do |format|
      format.html
      format.csv { send_data @reviews.to_csv(['id', 'user_id', 'trip_id', 'rating', 'comment', 'created_at', 'updated_at']) }
    end

  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to admin_reviews_path
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    redirect_to admin_reviews_path unless @review
    @review.destroy
    redirect_to admin_reviews_path
  end

  def edit
    @review = Review.find_by(id: params[:id])
    redirect_to admin_reviews_path unless @review
  end

  def update
    @review = Review.find_by(id: params[:id])
    @review.update(review_params)
    redirect_to admin_reviews_path
  end

  def import
    Review.import()
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:rating, :user_id, :trip_id, :comment)
  end
end