class TripsController < ApplicationController

  # GET /trips or /trips.json
  def index

    @trips = Trip.all

    #########################################
    # 1- busqueda por nombre, ciudad o pais
    # 2- busqueda por filtros
    #########################################

    if params[:sch].present?
      @trips = Trip.search(params[:sch])
    else
      if params[:minp].present?
        if params[:maxp].present?
          @trips_price = Trip.where("price >= ? AND price <= ?", params[:minp], params[:maxp])
        else
          @trips_price = Trip.where("price >= ?", params[:minp])
        end

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

      elsif params[:maxp].present?
        if params[:minp].present?
          @trips_price = Trip.where("price >= ? AND price <= ?", params[:minp], params[:maxp])
        else
          @trips_price = Trip.where("price <= ?", params[:maxp])
        end

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

  end

  # GET /trips/1 or /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @organizer = User.find_by(id: @trip.organizer_id)
    @reviews = Review.trip_reviews(@trip)
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params.merge(organizer_id: current_user.id))
    @trip.save
    redirect_to new_preference_path(trip_id: @trip.id)
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    redirect_to trips_path unless @trip
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    @trip.update(trip_params)
    redirect_to trips_path
  end

  private
  
  def trip_params
    params.require(:trip).permit(:title, :subtitle, :image_url, :description, :price)
  end

  
end
