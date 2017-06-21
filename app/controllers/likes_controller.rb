class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    redirect_to "/secrets"
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.user ==  current_user
      @like.destroy
    end

    redirect_to "/secrets"
  end

  private
    def like_params
      params.require(:like).permit(:secret_id).merge(user: current_user)
    end
end
