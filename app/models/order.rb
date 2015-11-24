class Order < ActiveRecord::Base

  before_save :default_status

  belongs_to :user

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  enum status: [:pending, :paid, :cancel]

  scope :order_by_status, -> { order(:status, :id) }

  def default_status
    self.status ||= 0
  end

end
