class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  enum status: [:pending, :paid, :cancel]
end
