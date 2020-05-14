class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login
    if params[:email] == '123' && params[:password] == '123'
      @user = User.first
      render json: { message: 'ok', user_id: @user.id }, status: 200
    else
      render json: { message: 'invalid user email or password'}, status: 401
    end
  end
  def logout
    render json: { message: 'you have been logged out'}, status: 200
  end

  private

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?

    @user.valid_password?(params[:password])
    # valid_password? 是 Devise 提供的
  end
end 
