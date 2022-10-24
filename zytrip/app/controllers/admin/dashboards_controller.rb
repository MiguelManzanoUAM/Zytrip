class Admin::DashboardsController < ApplicationController
	before_action :authenticate_user!

	def landing

	end

	def dashboard

	end

	def testing

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

		
	end
end
