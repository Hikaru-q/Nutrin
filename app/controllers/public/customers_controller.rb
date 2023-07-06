class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
  end
  
  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
      flash[:notice] = "更新が完了しました"
    else
      flash[:alert] = "ユーザー情報を更新できませんでした"
      render :edit
    end
  end
    
  
  def confirm
  end
  
  def withdraw
    @customer = current_customer
    if @customer.email == 'guest@example.com'
      redirect_to root_path
      flash[:notice] = "ゲストユーザーは退会できません"
    else
      @customer.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理が完了しました"
      redirect_to root_path
    end
  end
  
  def followeds
    @customer = Customer.find(params[:id])
    @customers = @customer.following_customers
  end

  def followers
    @customer = Customer.find(params[:id])
    @customers = @customer.follower_customers
  end
  
   private
   
  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :profile_image)
  end
  
  def ensure_correct_user
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer)
    end
  end
   
end
