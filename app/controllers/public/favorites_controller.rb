class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @favorites = current_customer.favorites.page(params[:page]).per(4)
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    post.create_notification_favorite!(current_customer)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end

  private

  def favorite_params
    params.require(:favorite).permit(:customer_id, :post_id)
  end
end

