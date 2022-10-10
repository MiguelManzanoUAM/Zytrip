class Admin::DashboardsController < ApplicationController
	before_action :authenticate_user!

	def landing

	end

	def dashboard

	end

	def testing
		@user = User.find_by(id: params[:user_id])

		if @user
			@trips_rating = User.user_trips_rating(@user)
			@preferences = User.user_trips_preferences(@user)
		end
	end
end
