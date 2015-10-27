class Order < ActiveRecord::Base

  belongs_to :user

  has_many :product_orders
  has_many :products, through: :product_orders

  enum status: [:pending, :paid, :cancel]

  default_scope { order(:status, :id) }

end
