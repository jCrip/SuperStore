class ProductsController < ApplicationController
  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    if params[:q].present?
      @products = Product.search_by_name(params[:q]).page(params[:page]).per(3)
    else
      @products = Product.all.includes(:category).page(params[:page]).per(6)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @reviews = @product.reviews.reverse
  end

  def like
    @like = @product.likes.build(user: current_user)

    if @product.liked_by? current_user
      @product.remove_like current_user
      redirect_to @product, notice: 'Tu like a sido eliminado :('
    elsif @product.save
      redirect_to @product, notice: 'Gracias por tu like :D'
    else
      redirect_to @product, notice: 'Tu like no se ha guardado :('
    end
  end

  def add_to_cart
    quantity = params[:quantity] || 1
    cart = Cart.find_or_initialize_by(product_id: params[:id])
    cart.user = current_user if user_signed_in?
    cart.product = Product.find(params[:id])
    cart.quantity = quantity
    cart.save

    flash[:success] = 'Producto añadido a tu carro'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
