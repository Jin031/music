class Admin::CustomersController < ApplicationController
 before_action :authenticate_admin!
 def index
  @customers = Customer.all.page(params[:page])
 end

 def show
  @customer = Customer.find(params[:id])
 end

 def customer_params
  params.require(:customer).permit(:name, :introduction, :email, :is_deleted)
 end

end
