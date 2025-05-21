class FavoritesController < ApplicationController
  before_action :require_login

  def index
    @favorites = Favorite.includes(:post).where(user_id: session[:user_id])
  end

  def create
    post = Post.find(params[:post_id])
    current_user.favorites.create(post: post)
    redirect_back fallback_location: root_path
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy if favorite
    redirect_back fallback_location: root_path
  end

  private

  def require_login
    redirect_to login_path, alert: "ログインしてください" unless session[:user_id]
  end
end
