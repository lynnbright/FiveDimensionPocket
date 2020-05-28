class TagsController < ApplicationController
  def show
    @tag = current_user.tags.find(params[:id])
  end  
end
