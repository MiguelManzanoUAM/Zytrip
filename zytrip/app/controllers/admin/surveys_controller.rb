class Admin::SurveysController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @surveys = Survey.all

    respond_to do |format|
      format.html
      format.csv { send_data @surveys.to_csv(['id', 'user_id', 'results_rating', 'preferences_poll_rating', 'zytrip_rating', 'comment', 'created_at', 'updated_at']) }
    end

  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.save
    redirect_to admin_surveys_path
  end

  def destroy
    @survey = Survey.find_by(id: params[:id])
    redirect_to admin_surveys_path unless @survey
    @survey.destroy
    redirect_to admin_surveys_path
  end

  def edit
    @survey = Survey.find_by(id: params[:id])
    redirect_to admin_surveys_path unless @survey
  end

  def update
    @survey = Survey.find_by(id: params[:id])
    @survey.update(survey_params)
    redirect_to admin_surveys_path
  end

  def import
    Survey.import()
    redirect_to admin_surveys_path
  end

  private

  def survey_params
    params.require(:survey).permit(:user_id, :results_rating, :preferences_poll_rating, :zytrip_rating, :comment)
  end
end