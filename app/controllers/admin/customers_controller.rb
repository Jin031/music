class Admin::CustomersController < ApplicationController
 before_action :authenticate_admin!
 def index
  @customers = Customer.all.page(params[:page])
 end

 def show
  @customer = Customer.find(params[:id])
 end

 def unsubscribe
  @customer = Customer.find(params[:id])
  @customer.update(is_deleted: true)
  redirect_to admin_customers_path, notice: "この会員を退会させました"
 end

 def customer_params
  params.require(:customer).permit(:name, :introduction, :email, :is_deleted)
 end
end
