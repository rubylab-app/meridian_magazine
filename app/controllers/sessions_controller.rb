class SessionsController < ApplicationController
  layout false

  def new
    @users = User.order(:role)
  end

  def create
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    redirect_to "/admin"
  end

  def destroy
    reset_session
    redirect_to "/login"
  end
end
