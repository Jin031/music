class Public::CustomersController < ApplicationController
 before_action :authenticate_customer!
 def show
  @customer = Customer.find(params[:id])
 end

 def edit
  @customer = Customer.find(params[:id])
 end

 def update
  @customer = current_customer
  @customer.update(customer_params)
  redirect_to customer_path
 end

 def withdraw
 end

 def unsubscribe
  @customer = current_customer
  @customer.update(is_deleted: true)
  sign_out_and_redirect(current_customer)
 end

 private

 def customer_params
  params.require(:customer).permit(:name, :introduction, :email, :profile_image)
 end
end


