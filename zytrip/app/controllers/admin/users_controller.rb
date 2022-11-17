class Admin::UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		unless current_user and current_user.admin?
      		redirect_to root_path, error: "You don't belong there"
    	end
    
    	@users = User.all()

    	respond_to do |format|
      		format.html
      		format.csv { send_data @users.to_csv(['id', 'name', 'surname', 'email', 'image', 'admin', 'created_at', 'updated_at', 'encrypted_password', 'reset_password_token', 'reset_password_sent_at', 'remember_created_at']) }
    	end

    	@users = User.search(params[:search])
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.save
		redirect_to admin_users_path
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

	def import
	    User.import()
	    redirect_to admin_users_path
	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :admin)
	end

end

