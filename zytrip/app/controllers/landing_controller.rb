class LandingController < ApplicationController
	def home
		#3 most popular trips

		if !session[:theme]
			session[:theme] = "light"
		end
		
		if !session[:nav_count]
			session[:nav_count] = 0
		else
			session[:nav_count] += 1
		end

		Trip.destroy_unsaved_trips()
		
		@popular_trips = Trip.get_most_popular_trips()

		if current_user
			@user = current_user
			@trips_recomendated = User.most_afinity_preferences_trips(@user)
			@most_similar_users = Review.get_most_similar_users_by_reviews(@user).first(3)
			@friends_trips = Review.get_most_popular_friends_trips(@user).keys.first(3)
		end


		if session[:trips_ids]
			@session_visited_trips = session[:trips_ids]
			@session_trips = Trip.get_most_similar_trips(session[:trips_ids])
		end

	end

	def about

	end

	def guide

	end
end