module PostsHelper
  def favorited?(post)
    current_user.favorites.exists?(post_id: post.id)
  end
end
