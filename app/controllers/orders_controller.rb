class OrdersController < ApplicationController
  load_and_authorize_resource

  def show
    @order = Order.find(params[:id])
    @product_orders = ProductOrder.where(order: @order)
  end

  def create_order
    carts = current_user.carts
    order = Order.create(user: current_user)
    carts.each do |c|
      order.product_orders.build(
        product: c.product,
        quantity: c.quantity
      ).save
      c.product.update_stock(-c.quantity)
    end

    carts.destroy_all
    redirect_to order
  end

  def paid_order
    @order = Order.find(params[:id])
    @order.paid!
    OrderMailer.confirmation_email(@order, current_user).deliver_later
    OrderMailer.confirmation_admin(@order).deliver_later
    redirect_to :back
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.cancel!

    @order.product_orders.each do |po|
      po.product.update_stock(po.quantity)
    end

    redirect_to :back
  end

end
