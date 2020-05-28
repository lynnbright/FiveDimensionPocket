class ProfilesController < ApplicationController
  def index
    @user = User.includes(:articles).find_by(id: params[:id], articles: {publish: true})
  end
end
