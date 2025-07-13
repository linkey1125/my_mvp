# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :require_login  # Sorcery使ってる想定

  def create
    @post = Post.find(params[:post_id])
    @review = @post.reviews.build(review_params.merge(user: current_user))

    if @review.save
      redirect_to @post, notice: "レビューを投稿しました"
    else
      redirect_to @post, alert: "レビュー投稿に失敗しました: " + @review.errors.full_messages.join(", ")
    end
  end

  def destroy
    review = current_user.reviews.find(params[:id])
    review.destroy
    redirect_to post_path(review.post), notice: "レビューを削除しました"
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
