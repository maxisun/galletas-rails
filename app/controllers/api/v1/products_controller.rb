class Api::V1::ProductsController < ApplicationController
  rescue_from Pagy::OverflowError, :with => :redirect_to_last_page
  rescue_from Pagy::VariableError, :with => :page_and_size_error
  rescue_from ActiveRecord::RecordNotFound, :with => :product_not_found
  #rescue_from ActionController::ParameterMissing, :with => :product_not_created
  before_action :authenticate_request!, except: [:index]
  before_action :load_current_user!, only: [:create, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  # GET /products
  def index
    query = Product.name_asc #default
    if params[:filter]
      query = Product.search_name(params[:filter])
    end
    if params[:sort]
      f = params[:sort].split(',').first
      field = f[0] == '-' ? f[1..-1] : f
      order = f[0] == '-' ? 'DESC' : 'ASC'
      if Product.new.has_attribute?(field)
        query = query.order("#{field} #{order}")
      end
    end
    @pagy, @products = pagy(query, page: params[:page], items: params[:per_page])
  end

  # GET /product/:id
  def show
  end

  # POST /products
  def create
    if @current_user.is_admin?
      @product = Product.new(product_params)
      if @product.save
        render 'show', status: 201
      else
        render :json => { :errors => @product.errors.full_messages }, status: 400
      end
    else
      render json: {error: "Unauthorized: You must be an admin to perform that action"}, status: :unauthorized
    end
  end

  def update
    old_price = @product.price
    if @product.update(product_update_params)
      puts @product.price
      puts old_price
      PriceLog.create(product_id: @product.id, user_id: @current_user.id, previousPrice: old_price, updatedPrice: @product.price)
      render 'show', status: 200
    else
      render :json => { :errors => @product.errors.full_messages }, status: 400
    end
  end

  def destroy
    if @current_user.is_admin?
      if @product.destroy
        render json: { message: "Product Successfully Deleted." }, status: 200
      else
        product_not_found
      end
    else
      render json: {error: "Unauthorized: You must be an admin to perform that action"}, status: :unauthorized
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

  def product_update_params
    params.require(:product).permit(:price)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def redirect_to_last_page(exception)
    #redirect_to url_for(page: exception.pagy.last)#, notice: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
    render json: {error: "Page ##{params[:page]} is overflowing."}, status: 400
  end

  def page_and_size_error(exception)
    render json: {error: "page and per_page params must be >= 1"}, status: 400
  end

  def sort_product
    products = Product.all
    if params[:sort]
      f = params[:sort].split(',').first
      field = f[0] == '-' ? f[1..-1] : f
      order = f[0] == '-' ? 'DESC' : 'ASC'
      if Product.new.has_attribute?(field)
        products = products.order("#{field} #{order}")
      end
    end
  end

end
