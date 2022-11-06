class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(user_id: current_user.id, trip_id: params[:trip_id], rating: params[:rating], comment: params[:comment])
    @survey.save
    redirect_to trips_path
  end

  private
  
  def survey_params
    params.require(:survey).permit(:rating, :trip_id, :comment)
  end
end
