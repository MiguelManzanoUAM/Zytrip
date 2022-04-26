class LandingController < ApplicationController
	def home
		#3 most popular trips
		@trips_recomendated = Trip.order("rating DESC").take(3)
	end
end