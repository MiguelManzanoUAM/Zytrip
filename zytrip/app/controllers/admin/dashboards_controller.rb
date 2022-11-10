class Admin::DashboardsController < ApplicationController
	before_action :authenticate_user!

	def dashboard
		@trips = Trip.all.size
		@users = User.all.size
		@surveys = Survey.all
		@users_results_percentage = Survey.get_results_rating_percentage
		@users_searches_percentage = Survey.get_searches_rating_percentage
		@users_zytrip_percentage = Survey.get_zytrip_rating_percentage
		@users_with_various_surveys = Survey.get_users_with_various_surveys
		@users_results_improved_percentage = Survey.get_users_results_rating_improved_percentage
		@users_searches_improved_percentage = Survey.get_users_searches_rating_improved_percentage
		@users_zytrip_improved_percentage = Survey.get_users_zytrip_rating_improved_percentage
		@lowest_surveys_rating = Survey.get_lowest_rating_surveys
		@latest_surveys = Survey.get_latest_surveys
	end

	def testing

		#####################################################################
		# Test recomendador basado en popularidad
		#####################################################################
		@trips_by_clients = Trip.trips_by_clients_number()
		@most_popular_trips = Trip.get_most_popular_trips()

		#####################################################################
		# Test recomendador basado en contenido y categorias (conocimiento)
		#####################################################################
		@user = User.find_by(id: params[:user_id])

		if @user
			@trips_rating = User.user_trips_rating(@user)
			@preferences = User.user_trips_preferences(@user)
			@preferences_values = User.user_calculate_preferences(@user)
			@final_preferences = User.valuable_preferences(@user)
			@candidates = User.user_candidate_preferences_matrix(@user)
			@candidates_affinities = User.user_candidate_preferences_afinity(@user)
			@final_candidates = User.most_afinity_preferences_trips(@user)
		end

		#####################################################################
		# Test recomendador colaborativo (filtrado social)
		#####################################################################
		@user_social = User.find_by(id: params[:social_id])

		if @user_social
			@user_reviews = Review.get_user_reviews(@user_social)

			if @user_reviews
				@other_user_reviews = Review.get_users_sharing_trips(@user_social)

				if @other_user_reviews
					@similar_reviews = Review.get_similar_reviews(@user_social)

					if @similar_reviews
						@similar_reviews_users = Review.get_similar_reviews_users(@user_social)

						if @similar_reviews_users
							@similar_reviews_users_difference = Review.get_similar_users_by_reviews(@user_social)
							@most_similar_users_by_reviews = Review.get_most_similar_users_by_reviews(@user_social).first(3)
						end
					end
				end
			end
		end

		#####################################################################
		# Test recomendación según usuarios que sigues
		#####################################################################
		@follower_user = User.find_by(id: params[:follower_id])

		if @follower_user
			@friends = @follower_user.friends
			@followed_reviews = Review.get_followed_users_reviews(@follower_user)
			@friends_popular_trips = Review.get_most_popular_friends_trips(@follower_user)
			@friends_most_popular_trips = @friends_popular_trips.keys.first(3)
		end
		
	end
end
