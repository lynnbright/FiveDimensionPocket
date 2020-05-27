class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def follow
    if current_user.follow_lists.where(following_id: params[:id]).any?
      current_user.follow_lists.find_by(following_id: params[:id]).destroy
      render json: { follow: false }
    else 
      current_user.follow_lists.create(user_id: current_user.id, following_id: params[:id])
      render json: { follow: true }
    end
  end

  def tags
    all_tags = current_user.tags.select("name","counter").where("counter > 0")
    if all_tags.any?
      render json: { tags: all_tags }
    else 
      render json: { tags: false }
    end
  end

end
