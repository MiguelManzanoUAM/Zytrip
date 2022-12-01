class LandingController < ApplicationController
	def home
		#3 most popular trips

		Trip.destroy_unsaved_trips()
		
		@popular_trips = Trip.get_most_popular_trips()

		if current_user
			@user = current_user
			@trips_recomendated = User.most_afinity_preferences_trips(@user)
			@most_similar_users = Review.get_most_similar_users_by_reviews(@user).first(3)
			@friends_trips = Review.get_most_popular_friends_trips(@user).keys.first(3)
		end

	end

	def about

	end
end