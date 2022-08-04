class TripsController < ApplicationController

  # GET /trips or /trips.json
  def index
    @trips = Trip.all

    if params[:minp].present? || params[:maxp].present?
      @trips_price = Trip.where("price >= ? AND price <= ?", params[:minp], params[:maxp])
      if params[:stars4]
        @trips = @trips_price.where("rating >= 4")
      elsif params[:stars3]
        @trips = @trips_price.where("rating >= 3")
      elsif params[:stars2]
        @trips = @trips_price.where("rating >= 2")
      elsif params[:stars1]
        @trips = @trips_price.where("rating >= 1")
      else
        @trips = @trips_price
      end
    else
      if params[:stars4]
        @trips = Trip.where("rating >= 4")
      elsif params[:stars3]
        @trips = Trip.where("rating >= 3")
      elsif params[:stars2]
        @trips = Trip.where("rating >= 2")
      elsif params[:stars1]
        @trips = Trip.where("rating >= 1")
      else
        @trips = Trip.all
      end
    end

  end

  # GET /trips/1 or /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @agency = Agency.find(@trip.agency_id)
  end


end
