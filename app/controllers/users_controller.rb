class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :authorize_user, except: [:new, :create]
  def new
  end

  def show
    @u = User.find(params[:id])
  end

  def create
    u = User.new(user_params)
    u.save
    if !u.save
      flash[:errors] = ["can't be blank"]
      redirect_to "/users/new"
    else
      redirect_to "/sessions/new"

    end
  end

  def edit
    @u = User.find(params[:id])
  end

  def update
    @u = User.find(params[:id])
    if @u.update(user_params)
      redirect_to "/users/#{@u.id}"
    else
      flash[:errors] = @u.errors.full_messages
      redirect_to "/users/#{@u.id}/edit"
    end
  end

  def destroy
    @u = User.find(params[:id])
    @u.destroy
    session[:user_id] = nil
    redirect_to "/users/new"

  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def authorize_user
      redirect_to "/users/#{session[:user_id]}" unless current_user === User.find(params[:id])
    end
end
