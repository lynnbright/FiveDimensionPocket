class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def follow
    # 判斷已追蹤還是沒追蹤
    if current_user.follow_lists.where(following_id: params[:id]).any?
      current_user.follow_lists.find_by(following_id: params[:id]).destroy
      render json { follow: false }
    else 
      current_user.follow_lists.create(following_id: params[:id])
      render json { follow: true }
    end
  end

end
