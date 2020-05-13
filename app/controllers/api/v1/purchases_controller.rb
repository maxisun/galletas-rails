class Api::V1::PurchasesController < ApplicationController
  before_action :authenticate_request!
  before_action :load_current_user!
  before_action :set_product, only: [:create]

  def logs
    if @current_user.is_admin?
      @purchases_logs = Purchase.all
    else
      render json: {error: "Unauthorized: You must be an admin to perform that action"}, status: :unauthorized
    end
  end

  def create
    if @product.update(stock: @product.stock - purchase_params[:quantity])
      Purchase.create(product_id: @product.id, user_id: @current_user.id, quantity: purchase_params[:quantity])
      render 'show', status: 201
    else
      render json: { error: "Quantity is greater than available stock" }, status: 400
    end
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def purchase_params
    params.require(:purchase).permit(:quantity)
  end
end
