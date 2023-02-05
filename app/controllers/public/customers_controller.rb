class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:posts]
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customer_path, notice: "保存しました"
  end

  def withdraw
  end

  def unsubscribe
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out_and_redirect(current_customer)
  end

  def posts
    @customer = Customer.find(params[:id])
     if current_customer && current_customer.id == @customer.id
       @posts = current_customer.posts
     else
       @posts = @customer.posts
     end
    @posts = @posts.page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :profile_image, :is_deleted)
  end
end


