class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Hi #{user.name} you are now logged in ...!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "You just logged out ...!"
  end
end
