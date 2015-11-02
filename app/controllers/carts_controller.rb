class CartsController < ApplicationController
  load_and_authorize_resource

  def show
    user = User.find(current_user)
    @carts = user.carts
  end

  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Producto eliminado del carro' }
      format.json { head :no_content }
    end
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end

end
