module RelationshipsHelper
  def followed_id(current_user, user)
    followed = Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
    followed.id
  end
end
