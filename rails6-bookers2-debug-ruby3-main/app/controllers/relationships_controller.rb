class RelationshipsController < ApplicationController
  def following
    @user = User.find(params[:user_id])
  end

  def followers
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    follow = Relationship.new(followed_id: @user.id)
    follow.follower_id = current_user.id
    follow.save
  end

  def destroy
    @user = User.find(params[:user_id])
    Relationship.find_by(followed_id: @user.id, follower_id: current_user.id).destroy
  end
end
