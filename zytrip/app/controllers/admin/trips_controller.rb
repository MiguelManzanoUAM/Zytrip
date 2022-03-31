class Admin::TripsController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @trips = Trip.search(params[:search])
  end

  def show

  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.save
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    redirect_to admin_trips_path unless @trip
    @trip.destroy
    redirect_to admin_trips_path
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    redirect_to admin_trips_path unless @trip
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    @trip.update(trip_params)
    redirect_to admin_trips_path
  end


  private

    def trip_params
      params.require(:trip).permit(:title, :body)
    end
end
