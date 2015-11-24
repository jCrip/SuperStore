class Admin::OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :require_admin
  layout 'admin'
  # GET /admin/orders
  # GET /admin/orders.json
  def index
    @orders = Order.order_by_status
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    @product_orders = ProductOrder.where(order: @order)
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end
