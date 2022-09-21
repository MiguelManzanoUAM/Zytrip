class Admin::TopicsController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @topics = Topic.all

    respond_to do |format|
      format.html
      format.csv { send_data @topics.to_csv(['id', 'preference_id', 'beach', 'nature', 'tourism']) }
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.save
    redirect_to admin_topics_path
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    redirect_to admin_topics_path unless @topic
    @topic.destroy
    redirect_to admin_topics_path
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
    redirect_to admin_topics_path unless @topic
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    @topic.update(topic_params)
    redirect_to admin_topics_path
  end

  def import
    Topic.import()
    redirect_to admin_topics_path
  end

  def topic_params
    params.require(:topic).permit(:preference_id, :beach, :nature, :tourism)
  end
end