class TopicsController < ApplicationController
	def new
    	@topic = Topic.new
  	end

  	def create
  		@preference = Preference.last
    	@topic = Topic.new(topic_params.merge(preference_id: @preference.id))
    	@topic.save
    	redirect_to trips_path
  	end

  	def destroy
    	@topic = Topic.find_by(id: params[:id])
    	redirect_to admin_topics_path unless @topic
    	@topic.destroy
    	redirect_to admin_topics_path
  	end

  	private

  	def topic_params
    	params.require(:topic).permit(:beach, :nature, :tourism, :relax)
  	end
end