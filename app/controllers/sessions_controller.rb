class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    #render login page
  end
  def create
    u = User.find_by_email(params[:Email]).try(:authenticate, params[:Password])

    if !u
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/sessions/new"
    else
      session[:user_id] = u.id
      redirect_to "/users/#{current_user.id}"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
end
