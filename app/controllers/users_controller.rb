class UsersController < ApplicationController
  def show
    @user = User.includes(:articles).find_by(id: params[:id], articles: {publish: true})
  end
end
