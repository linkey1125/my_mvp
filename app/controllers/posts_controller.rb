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

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      flash[:alert] = @post.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

def destroy
  @post = current_user.posts.find(params[:id])
  if @post.destroy
    redirect_to root_path, notice: "投稿を削除しました！"
  else
    redirect_to post_path(@post), alert: "投稿の削除に失敗しました"
  end
end

def search
  @posts = Post.all

  if params[:keyword].present?
    @posts = @posts.where("title LIKE ? OR content LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  end

  if params[:uv_cut_rate].present?
    @posts = @posts.where(uv_cut_rate: params[:uv_cut_rate])
  end

  if params[:category].present?
    @posts = @posts.where(category: params[:category])
  end

  if params[:price_range].present?
    @posts = @posts.where(price_range: params[:price_range])
  end

  render :index
end

  private

def post_params
  params.require(:post).permit(:title, :content, :image, :uv_cut_rate, :category, :price_range)
end


  def require_login
    redirect_to login_path, alert: "ログインしてください" unless session[:user_id]
  end
end
