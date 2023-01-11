class Public::FollowsController < ApplicationController
   # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    Follow.where(follower_id: current_customer.id, followed_id: params[:customer_id]).first.create_notification_follow!
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
