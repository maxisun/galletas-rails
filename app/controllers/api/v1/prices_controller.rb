class Api::V1::PricesController < ApplicationController
  before_action :authenticate_request!
  before_action :load_current_user!

  def logs
    if @current_user.is_admin?
      @price_logs = PriceLog.all
    else
      render json: {error: "Unauthorized: You must be an admin to perform that action"}, status: :unauthorized
    end
  end
end
