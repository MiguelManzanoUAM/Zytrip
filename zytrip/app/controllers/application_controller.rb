class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

		#redirect to admin_path if admin
		def after_sign_in_path_for(resource)
			if current_user.admin == true
				admin_dashboards_dashboard_path
			else
				root_path
			end
		end

		#Add fields to devise register form
		def configure_permitted_parameters
	       devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password)}

	       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :password, :current_password)}
		end

end
