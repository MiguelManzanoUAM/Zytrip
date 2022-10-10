class UsersController < ApplicationController

	before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
	end

end