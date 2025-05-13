class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿しました！"
    else
      flash[:alert] = @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def require_login
    redirect_to login_path, alert: "ログインしてください" unless session[:user_id]
  end
end
