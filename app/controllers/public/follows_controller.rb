class Public::FollowsController < ApplicationController
   before_action :authenticate_customer!
   # フォローするとき
  def create
    follow = current_customer.follow(params[:customer_id])
    follow.create_notification_follow!
    redirect_to request.referer, notice: "フォローしました"
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.page(params[:page]).per(4)
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.page(params[:page]).per(4)
  end

  private

  def follow_params
   params.require(:follow).permit(:follower_id, :followed_id)
  end
end
