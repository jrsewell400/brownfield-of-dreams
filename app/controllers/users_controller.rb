require 'faraday'
require 'json'

class UsersController < ApplicationController
  def show
    @repos = JSON.parse(connection.body, symbolize_names: true)[0..4]
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def connection
    conn = Faraday.new(url: "https://api.github.com",
                       params: { access_token: "297f3266de9167cd907402888af4721c431bb1dc" })
    conn.get('/user/repos')
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
