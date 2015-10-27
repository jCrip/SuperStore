class Review < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  belongs_to :product

  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user

  validates :content, presence: true

end
