class PreferencesController < ApplicationController
	def new
    	@preference = Preference.new
  	end

  	def create
  		@trip = Trip.last

  		if preference_params[:destination] == 0
  			@destination = 0
  		elsif preference_params[:destination] == "Europa"
  			@destination = 1
  		elsif preference_params[:destination] == "África"
  			@destination = 2
  		elsif preference_params[:destination] == "América"
  			@destination = 3
  		else
  			@destination = 4
  		end

  		if preference_params[:duration] == "Menos de 3 días"
  			@duration = 0
  		elsif preference_params[:duration] == "Entre 3 y 5 días"
  			@duration = 1
  		elsif preference_params[:duration] == "Entre 5 y 7 días"
  			@duration = 2
  		else
  			@duration = 3
  		end

  		if @trip.price < 500
  			@preference = Preference.new(trip_id: @trip.id, budget: 0, destination: @destination, duration: @duration)
  			#@preference = Preference.new(preference_params.merge(trip_id: @trip.id, budget: 0))
    	elsif (@trip.price >= 500 && @trip.price < 1000)
    		@preference = Preference.new(trip_id: @trip.id, budget: 1, destination: @destination, duration: @duration)
    		#@preference = Preference.new(preference_params.merge(trip_id: @trip.id, budget: 1))
    	elsif (@trip.price >= 1000 && @trip.price < 1500)
    		@preference = Preference.new(trip_id: @trip.id, budget: 2, destination: @destination, duration: @duration)
    		#@preference = Preference.new(preference_params.merge(trip_id: @trip.id, budget: 2))
    	else
    		@preference = Preference.new(trip_id: @trip.id, budget: 3, destination: @destination, duration: @duration)
    		#@preference = Preference.new(preference_params.merge(trip_id: @trip.id, budget: 3))
    	end

    	@preference.save
    	redirect_to new_topic_path(preference_id: @preference.id)
  	end

  	def destroy
    	@preference = Preference.find_by(id: params[:id])
    	redirect_to preferences_path unless @preference
    	@preference.destroy
    	redirect_to preferences_path
  	end

  	private

  	def preference_params
    	params.require(:preference).permit(:destination, :duration)
  	end

end