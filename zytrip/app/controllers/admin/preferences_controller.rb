class Admin::PreferencesController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @preferences = Preference.all

    respond_to do |format|
      format.html
      format.csv { send_data @preferences.to_csv(['id', 'trip_id', 'destination', 'budget', 'duration']) }
    end
  end

  def new
    @preference = Preference.new
  end

  def create
    @preference = Preference.new(preference_params)
    @preference.save
    redirect_to admin_preferences_path
  end

  def destroy
    @preference = Preference.find_by(id: params[:id])
    redirect_to admin_preferences_path unless @preference
    @preference.destroy
    redirect_to admin_preferences_path
  end

  def edit
    @preference = Preference.find_by(id: params[:id])
    redirect_to admin_preferences_path unless @preference
  end

  def update
    @preference = Preference.find_by(id: params[:id])
    @preference.update(preference_params)
    redirect_to admin_preferences_path
  end

  def import
    Preference.import()
    redirect_to admin_preferences_path
  end

  def preference_params
    params.require(:preference).permit(:trip_id, :destination, :budget, :duration)
  end
end