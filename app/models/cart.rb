class Cart < ActiveRecord::Base

  belongs_to :product
  belongs_to :user

  def self.quantity_of product
    p = find_by(product_id: product)
    p ? p.quantity : 0
  end


  def self.total
    total = 0
    find_each do |c|
      total += c.quantity * c.product.price
    end
    total
  end

  def subtotal
    self.product.price * self.quantity
  end

end
