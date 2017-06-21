class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end
  def create
    @secrets = Secret.new(secret_params)
    @secrets.save
    if !@secrets.save
      flash[:errors] = @secrets.errors.full_messages
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to "/users/#{current_user.id}"
    end
  end

  def destroy
    @secret = Secret.find(params[:id])
    if @secret.user == current_user
      @secret.destroy
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to "/users/#{current_user.id}"
    end
  end

  private
    def secret_params
      params.require(:secret).permit(:content, :user_id)
    end
end
