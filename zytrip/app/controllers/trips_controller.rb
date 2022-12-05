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

    if session[:trips_ids]
      @session_trips = "Hay viajes de sesión"
    else
      @session_trips = "No hay viajes de sesión"
    end
  end

  # GET /trips/1 or /trips/1.json
  def show
    if session[:trips_ids]
      session[:trips_ids] << params[:id]
    else
      session[:trips_ids] = []
      session[:trips_ids] << params[:id]
    end

    @trip = Trip.find(params[:id])
    @organizer = User.find_by(id: @trip.organizer_id)
    @reviews = Review.trip_reviews(@trip)
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params.merge(organizer_id: current_user.id))

    if !@trip.save
      if (trip_params[:title].empty?)
        flash[:trip_error] = "Introduce un título para tu viaje"
      elsif trip_params[:title].length > 30
        flash[:trip_error] = "Introduce un título más corto (máximo 30 caracteres)"
      elsif (trip_params[:subtitle].empty?)
        flash[:trip_error] = "Rellena todos los campos que sean necesarios(*)"
      elsif trip_params[:subtitle].length > 50
        flash[:trip_error] = "piensa un subtítulo más corto (máximo 50 caracteres)"
      elsif (trip_params[:description].empty?)
        flash[:trip_error] = "Cuéntanos un poco como fue tu experiencia (itinerario, actividades...)"
      else
        flash[:trip_error] = "Introduce un precio (en euros) aproximado para tu viaje"
      end

      redirect_to new_trip_path(trip_id: @trip.id)
    else
      redirect_to new_preference_path(trip_id: @trip.id)
    end
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
