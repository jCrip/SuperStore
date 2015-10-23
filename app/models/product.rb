class Product < ActiveRecord::Base
  has_many :product_orders
  has_many :orders, through: :product_orders

  has_many :carts
  has_many :users, through: :carts
end
