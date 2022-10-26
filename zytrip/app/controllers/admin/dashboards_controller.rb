class Admin::DashboardsController < ApplicationController
	before_action :authenticate_user!

	def landing

	end

	def dashboard

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
			@other_user_reviews = Review.get_users_sharing_trips(@user_social)
			@similar_reviews = Review.get_similar_reviews(@user_social)
			@similiar_reviews_users = Review.get_similar_reviews_users(@user_social)
			@similar_reviews_users_difference = Review.get_similar_users_by_reviews(@user_social)
			@most_similar_users_by_reviews = Review.get_most_similar_users_by_reviews(@user_social)
		end
		
	end
end
