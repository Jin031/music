class Public::CustomersController < ApplicationController
 def show
  @customer = current_customer
 end

 def edit
  @customer = current_customer
 end

 def update
  @customer = current_customer
  @customer.update(customer_params)
  redirect_to customers_path
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
  params.require(:customer).permit(:name, :introduction, :email)
 end
end


