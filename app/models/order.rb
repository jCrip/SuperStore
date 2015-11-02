class Order < ActiveRecord::Base

  before_save :default_status

  belongs_to :user

  has_many :product_orders
  has_many :products, through: :product_orders

  enum status: [:pending, :paid, :cancel]

  default_scope { order(:status, :id) }

  def default_status
    self.status ||= 0
  end

end
