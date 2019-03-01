module LikesHelper
  def find_liked_post(current_user, post)
    Like.find_by(user_id: current_user.id, post_id: post.id)
  end
end
