class SessionsController < ApplicationController
  def create
    #TODO: change this later to verify a password
    if true
      session[:user_type] = "admin"
      flash[:notice] = "Successfully logged in!"
      redirect_to root_path
    else
      flash[:alert] = "Username or password not found.  Please try again"
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end
end
