class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(user_id: current_user.id, results_rating: params[:results_rating], preferences_poll_rating: params[:preferences_poll_rating], zytrip_rating: params[:zytrip_rating], comment: params[:comment])
    @survey.save
    redirect_to root_path
  end

  private
  
  def survey_params
    params.require(:survey).permit(:results_rating, :preferences_poll_rating, :zytrip_rating, :comment)
  end
end
