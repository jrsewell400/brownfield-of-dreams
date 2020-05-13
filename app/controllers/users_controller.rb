require './app/poros/github/response.rb'

class UsersController < ApplicationController
  def show
    @response = Response.new(current_user) if current_user.git_hub_token?
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      ActivationController.create(user) if Rails.env.development?
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.full_name}.\nThis account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'An account with that email already exists.'
      redirect_back fallback_location: register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
