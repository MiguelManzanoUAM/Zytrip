class FriendshipsController < ApplicationController

  def add_friend
    @current_user = current_user
    @friend = User.find_by(id: params[:id])
    Friendship.add_friend(@current_user, @friend)
    redirect_to users_profile_path(@friend.id)
  end

  def delete_friend
    @current_user = current_user
    @friend = User.find_by(id: params[:id])
    Friendship.delete_friend(@current_user, @friend)
    redirect_to users_profile_path(@current_user)
  end

  def destroy
    @current_user = current_user
    @friendship = Friendship.find_by(id: params[:id])
    redirect_to users_profile_path(@current_user) unless @friendship
    @friendship.destroy
    redirect_to users_profile_path(@current_user)
  end
end