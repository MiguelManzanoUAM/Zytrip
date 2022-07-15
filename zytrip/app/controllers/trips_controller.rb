class TripsController < ApplicationController

  # GET /trips or /trips.json
  def index
    @trips = Trip.all

    #if params[:minp].present? || params[:maxp].present?
      #@trips = Trip.where("price >= ? AND price <= ?", params[:minp], params[:maxp])
    #else
      #@trips = Trip.all
    #end

    if params[:stars4]
      @trips = Trip.where("price >= 300")
    elsif params[:stars3]
      @trips = Trip.where("price >= 900")
    else
      @trips = Trip.all
    end

    
  end

  # GET /trips/1 or /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @agency = Agency.find(@trip.agency_id)
  end


end
