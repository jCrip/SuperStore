class ReviewsController < ApplicationController
  # before_action :authenticate_user!
  load_and_authorize_resource

  def create
    product = Product.find(params[:product_id])

    @review = product.reviews.build(review_params)
    @review.user = current_user if user_signed_in?
    @review.save

    redirect_to product
  end

  def like
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @like = @review.likes.build(user: current_user)

    if @review.liked_by? current_user
      @review.remove_like current_user
      redirect_to @product, notice: 'Tu like a sido eliminado :('
    elsif @like.save
      redirect_to @product, notice: 'Gracias por tu like :D'
    else
      redirect_to @product, notice: 'Tu like no se ha guardado :('
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:content)
    end
end
