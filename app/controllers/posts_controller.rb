class PostsController < ApplicationController
  def index
    redirect_to posts_path(category: "decizii") if params[:category].blank?
  end
end
