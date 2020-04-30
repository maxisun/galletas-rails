class Api::V1::ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :product_not_found
  #rescue_from ActionController::ParameterMissing, :with => :product_not_created
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /product/:id
  def show
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      render 'show', status: 201
    else
      render :json => { :errors => @product.errors.full_messages }, status: 400
      #render 'error', status: 400
    end
  end

  def update
    if @product.update(product_params)
      render 'show', status: 200
    else
      render :json => { :errors => @product.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @product.destroy
      render json: { message: "Product Successfully Deleted." }, status: 200
    else
      product_not_found
    end
  end

  private

  def product_not_found 
    render json: {error: "Product not found."}, status: 404
  end

  #def product_not_created
  #  render 'error', status: 400
  #end

  def product_params
    params.require(:product).permit(:name, :description, :stock, :price)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
