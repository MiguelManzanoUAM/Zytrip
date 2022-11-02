class FriendshipsController < ApplicationController

  def add_friend
    @current_user = current_user
    @friend = User.find_by(id: params[:id])
    Friendship.add_friend(@current_user, @friend)

    if params[:source] == "friend"
      redirect_to users_profile_path(@friend.id)
    elsif params[:source] == "profile"
      redirect_to users_profile_path(@current_user.id)
    elsif params[:source] == "list"
      @source_user = User.find_by(id: params[:source_user])
      redirect_to users_profile_path(@source_user.id)
    else
      redirect_to root_path
    end

  end

  def delete_friend
    @current_user = current_user
    @friend = User.find_by(id: params[:id])
    Friendship.delete_friend(@current_user, @friend)
    
    if params[:source] == "friend"
      redirect_to users_profile_path(@friend.id)
    elsif params[:source] == "mylist"
      redirect_to users_profile_path(@current_user.id)
    elsif params[:source] == "list"
      @source_user = User.find_by(id: params[:source_user])
      redirect_to users_profile_path(@source_user.id)
    else
      redirect_to root_path
    end

  end

  def destroy
    @current_user = current_user
    @friendship = Friendship.find_by(id: params[:id])
    redirect_to users_profile_path(@current_user) unless @friendship
    @friendship.destroy
    redirect_to users_profile_path(@current_user)
  end
end