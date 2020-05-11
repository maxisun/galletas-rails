class Api::V1::LikesController < ApplicationController
  before_action :authenticate_request!
  before_action :load_current_user!
  before_action :set_product

  def create
    return render json: {error: "Unauthorized: You must be an user to perform that action"}, status: :unauthorized unless !@current_user.is_admin?
    
    case 
    when already_liked? then render json: {error: "This product is already liked"}, status: 403
    else
      Like.create(product_id: @product.id, user_id: @current_user.id)
      @product.reload
      render 'show', status: 201
    end
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def already_liked?
    Like.where(product_id: @product.id, user_id: @current_user.id).exists?
  end
end
