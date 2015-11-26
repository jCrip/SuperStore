class Product < ActiveRecord::Base
  include ApplicationHelper
  include PgSearch
  extend FriendlyId

  friendly_id :name

  pg_search_scope :search_by_name,
                  against: [:name, :price],
                  associated_against: {category: :name},
                  :using => {
                    :tsearch => {any_word: true, prefix: true},
                    :trigram => { :threshold => 0.5, :only => [:name] }
                  },
                  :ranked_by => ":trigram"

 mount_uploader :image, ImageUploader

 belongs_to :category

 has_many :product_orders
 has_many :orders, through: :product_orders

 has_many :carts
 has_many :users, through: :carts

 has_many :reviews, dependent: :destroy

 has_many :likes, as: :likable
 has_many :user_likes, through: :likes, source: :user

 validates :name, presence: true, uniqueness: true
 validates :description, presence: true
 validates :price, presence: true
 validates :stock, presence: true
 validates :category, presence: true

 geocoded_by :address
 reverse_geocoded_by :latitude, :longitude

 after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

 after_validation :reverse_geocode, if: ->(obj) { (obj.latitude.present? && obj.longitude.present?) and (obj.latitude_changed? || obj.longitude_changed?) }

 def update_stock (quantity)
  self.stock += quantity
  self.save
end

end
