class Admin::UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.save
	end

	def destroy
		@user = User.find_by(id: params[:id])
		redirect_to admin_users_path unless @user
		@user.destroy
		redirect_to admin_users_path
	end

	def edit
		@user = User.find_by(id: params[:id])
		redirect_to admin_users_path unless @user
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to admin_users_path
	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :password)
	end

end

