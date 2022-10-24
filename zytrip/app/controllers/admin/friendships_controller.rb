class Admin::FriendshipsController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @friendships = Friendship.all

    respond_to do |format|
      format.html
      format.csv { send_data @friendships.to_csv(['id', 'user_id', 'friend_id']) }
    end
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.save
    redirect_to admin_friendships_path
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    redirect_to admin_friendships_path unless @friendship
    @friendship.destroy
    redirect_to admin_friendships_path
  end

  def import
    Friendship.import()
    redirect_to admin_friendships_path
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end