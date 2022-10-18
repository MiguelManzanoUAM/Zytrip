class TopicsController < ApplicationController
	def new
    	@topic = Topic.new
  	end

  	def create
  		@preference = Preference.last
    	@topic = Topic.new(topic_params.merge(preference_id: @preference.id))
    	@topic.save
    	redirect_to new_company_path
  	end

  	def topic_params
    	params.require(:topic).permit(:beach, :nature, :tourism, :relax)
  	end
end