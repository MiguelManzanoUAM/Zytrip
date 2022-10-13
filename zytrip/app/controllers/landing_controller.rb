class LandingController < ApplicationController
	def home
		#3 most popular trips
		@popular_trips = Trip.order("rating DESC").take(3)

		if current_user
			@user = current_user
			@trips_recomendated = User.most_afinity_preferences_trips(@user)
		end

	end
end