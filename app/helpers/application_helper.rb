module ApplicationHelper
  def remove_like user
    self.likes.where(user: user).first.delete
  end

  def liked_by?(user)
    self.user_likes.include? user
  end
end
