class CartsController < ApplicationController
  load_and_authorize_resource

  def show
    user = current_user
    @carts = user.carts
  end

  def destroy
    @cart.destroy

    user = current_user
    @carts = user.carts

    respond_to do |format|
      format.js { flash.now[:notice] = 'Producto eliminado del carro' }
    end
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end

end
