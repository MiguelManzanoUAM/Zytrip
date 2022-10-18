class ServicesController < ApplicationController

  def new
    @service = Service.new
  end

  def create
    @preference = Preference.last
    @service = Service.new(service_params.merge(preference_id: @preference.id))
    @service.save
    redirect_to trips_path
  end

  private
  
  def service_params
    params.require(:service).permit(:lodging, :gastronomy, :activities)
  end
end