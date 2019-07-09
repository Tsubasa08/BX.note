module CommentsHelper
  # 現在のユーザーが既にコメントをしていればtrue
  def comment?(comment)
    !current_user.comments.find_by(id: comment.id).nil?
  end
end
