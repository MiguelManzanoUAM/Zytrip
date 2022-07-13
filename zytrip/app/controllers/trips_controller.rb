class TripsController < ApplicationController

  # GET /trips or /trips.json
  def index
    @trips = Trip.all
  end

  # GET /trips/1 or /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @agency = Agency.find(@trip.agency_id)
  end

end
