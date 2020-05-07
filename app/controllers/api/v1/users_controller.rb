class Api::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: "User created successfully"}, status: 201
    else
      render :json => { :errors => @user.errors.full_messages }, status: :bad_request
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {Bearer: token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :is_admin)
  end

end
