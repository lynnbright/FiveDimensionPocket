class TagsController < ApplicationController
  def show
    @tag = current_user.tags.includes(:articles).find(params[:id])
  end  
end
