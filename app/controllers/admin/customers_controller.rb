class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!


  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path
      flash[:notice] = "更新が完了しました"
    else
      flash[:alert] = "ユーザー情報を更新できませんでした"
      render :edit
    end
  end

   private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :profile_image, :is_deleted)
  end

end
