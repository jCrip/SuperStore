class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  has_many :likes, as: :likeable
  has_many :user_likes, through: :likes, source: :user

  validates :content, presence: true

  # def remove_like user
  #   self.likes.where(user: user).first.delete
  # end

  # def liked_by?(user)
  #   self.user_likes.include? user
  # end

end
