class UsersController < ApplicationController

	before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
		@organized_trips = Trip.where(organizer_id: @user.id)
	end

	def update_aditional_info
		@user = User.find_by(id: params[:id])

		if params[:image_url]
			@user.image_url = params[:image_url]
		end

		if params[:phone_number]
			@user.phone_number = params[:phone_number]
		end

		if params[:description]
			@user.description = params[:description]
		end

		if params[:slogan]
			@user.update(user_aditional_params)
		end

		#intentar hacerlo con un form_for a ver si asi sale
		
		redirect_to users_profile_path(@user.id) unless @user
	end

	def edit
		@user = User.find_by(id: params[:id])
		redirect_to users_profile_path(@user.id) unless @user
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to users_profile_path(@user.id) unless @user
	end

	protected

	def user_aditional_params
		params.require(:user).permit(:image_url, :phone_number, :slogan, :description)
	end

end