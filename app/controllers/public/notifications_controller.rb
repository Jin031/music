class Public::NotificationsController < ApplicationController
   before_action :authenticate_customer!

  def index
    @notifications = current_customer.passive_notifications.where(checked: false).where.not(visitor_id: current_customer.id).page(params[:page]).per(3)
  end

  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true)
      redirect_to notifications_path
    end
  end

   private

  def notification_params
   params.require(:notification).permit(:visitor_id, :visited_id, :favorite_id, :comment_id, :post_id, :follow_id, :action, :checked)
  end
end
