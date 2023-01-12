class Public::FavoritesController < ApplicationController

  def index
    @favorites = current_customer.favorites
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    Favorite.where(customer_id: current_customer.id).first.create_notification_favorite!(current_customer)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end
end

