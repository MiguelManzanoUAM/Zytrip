class ApplicationController < ActionController::Base
	protected

	def after_sign_in_path_for(resource)
		if current_user.admin == true
			admin_dashboards_landing_path
		else
			trips_path
		end
	end

end
