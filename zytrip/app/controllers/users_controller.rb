class UsersController < ApplicationController

	before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
		@organized_trips = Trip.where(organizer_id: @user.id)
	end

end