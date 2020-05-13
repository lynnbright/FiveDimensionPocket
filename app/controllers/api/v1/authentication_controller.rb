class Api::V1::AuthenticationController < ApplicationController
  def login

  end
  def logout

  end

  private

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?

    @user.valid_password?(params[:password])
    # valid_password? 是 Devise 提供的
  end
end
